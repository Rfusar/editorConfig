local M = {}

M.globals = [[
@import "tailwindcss";

:root {
  --background: #ffffff;
  --foreground: #171717;
}


@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --font-sans: var(--font-geist-sans);
  --font-mono: var(--font-geist-mono);
}

@media (prefers-color-scheme: dark) {
  :root {
    --background: #0a0a0a;
    --foreground: #ededed;
    --font-inter: 'Inter', sans-serif;
  }
}

body {
  background: var(--background);
  color: var(--foreground);
  font-family: Arial, Helvetica, sans-serif;
}
]]

M.layout = [[
import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";

import Sidebar from "@/component/sidebar/init";
import Navbar from "@/component/navbar/init";


export const metadata: Metadata = {
  title: "Test Nextjs",
  description: "",
};

// Definizione del font
const geist = Geist({ subsets: ["latin"], weight: "400" });
const online = true

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`bg-gray-600 max-h-screen max-w-screen overflow-hidden text-black ${geist.className}`}>
        {online ? (
            <div className="flex flex-row h-screen w-screen bg-white">
                <Sidebar />
                <div className="h-screen w-full">
                    <Navbar />
                    {children}
                </div>
            </div>
        ) : (
            <div></div>
        )}
      </body>
    </html>
  );
}
]]
M.page = [[
"use client"

export default function Home() {
    return (
        <div className="p-2 h-[88%] grid grid-rows-2">

                <div className="grid grid-cols-2">
                    
                    <div className="grid grid-flow-col grid-rows-8 bg-green-200">
                        <div className="row-span-2 bg-red-200">
                            
                        </div>
                        <div className="row-span-6 bg-blue-200"></div>
                    </div>

                    <div className="bg-violet-200"></div>
                </div>
                
            
            <div className="overflow-hidden"></div>
        </div>
    )
}
]]

-- Config
M.package = [[
{
  "name": "test-nextjs",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "15.2.4",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "react-icons": "^5.5.0"
  },
  "devDependencies": {
    "@tailwindcss/postcss": "^4",
    "@types/node": "^20",
    "@types/react": "^19",
    "@types/react-dom": "^19",
    "tailwindcss": "^4",
    "typescript": "^5"
  }
}
]]

M.postcss = [[
const config = {
  plugins: ["@tailwindcss/postcss"],
};

export default config;
]]

M.typescript = [[
{
  "compilerOptions": {
    "target": "ES2017",
    "lib": [
      "dom",
      "dom.iterable",
      "esnext"
    ],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": false,
    "noEmit": true,
    "incremental": true,
    "module": "esnext",
    "esModuleInterop": true,
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": [
    "next-env.d.ts",
    ".next/types/**/*.ts",
    "**/*.ts",
    "**/*.tsx"
  ],
  "exclude": [
    "node_modules"
  ]
}
]]

return M
