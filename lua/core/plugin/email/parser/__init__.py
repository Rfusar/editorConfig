from email import policy
from email.parser import BytesParser
import quopri, base64

def parse_eml(eml_path):
    with open(eml_path, 'rb') as f:
        # Parsing del messaggio
        msg = BytesParser(policy=policy.default).parse(f)
    
    result = {
        'headers': dict(msg.items()),
        'body': {},
        'attachments': [],
        'structure': []
    }

    # Funzione ricorsiva per analizzare le parti del messaggio
    def parse_part(part, parent=None):
        part_info = {
            'content_type': part.get_content_type(),
            'content_disposition': part.get('Content-Disposition'),
            'charset': part.get_content_charset(),
            'size': len(part.get_payload(decode=True)) if not part.is_multipart() else None
        }

        if part.is_multipart():
            part_info['parts'] = [parse_part(p, part) for p in part.get_payload()]
            return part_info

        # Decodifica il contenuto
        payload = part.get_payload(decode=True)
        try:
            if part.get_content_type() == 'text/plain':
                part_info['content'] = payload.decode(part.get_content_charset() or 'utf-8')
            elif part.get_content_type() == 'text/html':
                part_info['content'] = payload.decode(part.get_content_charset() or 'utf-8')
            elif part.get('Content-Transfer-Encoding') == 'quoted-printable':
                part_info['content'] = quopri.decodestring(payload).decode(part.get_content_charset() or 'utf-8')
            else:
                part_info['content'] = "binary data"
        except UnicodeDecodeError:
            part_info['content'] = "binary data (decode failed)"

        # Gestione allegati
        if part.get_filename():
            payload = part.get_payload(decode=True)
            attachment = {
                'filename': part.get_filename(),
                'content_type': part.get_content_type(),
                'size': len(payload),
                #'content': base64.b64encode(payload).decode('utf-8'),  # Base64 per JSON
                'encoding': 'base64',  # Specifica l'encoding usato
                'content_id': part.get('Content-ID', '').strip('<>')
            }
            result['attachments'].append(attachment)

        return part_info

    # Analisi della struttura del messaggio
    if msg.is_multipart():
        result['structure'] = [parse_part(part) for part in msg.get_payload()]
    else:
        result['structure'] = parse_part(msg)

    # Estrazione del corpo principale
    for part in msg.walk():
        if part.get_content_type() == 'text/plain':
            result['body']['plain'] = part.get_payload(decode=True).decode(part.get_content_charset() or 'utf-8')
        elif part.get_content_type() == 'text/html':
            result['body']['html'] = part.get_payload(decode=True).decode(part.get_content_charset() or 'utf-8')

    return result

