# Guide to Using the Content Generation API

## Project Overview

This comprehensive guide outlines best practices, conventions, and standards for development with modern web technologies including ReactJS, Vite, TypeScript, JavaScript, HTML, CSS, and UI frameworks. The guide emphasizes clean, maintainable, and scalable code following SOLID principles and functional programming patterns.

## Tech Stack

- **Frontend Framework**: Vite + ReactJS
- **Language**: TypeScript (strict mode enabled)
- Always create components do not use monolithic pages.

## MUST HAVE

Do not create API Backend.
And always create components.

If you got parameter name "token", you should use it and save it as cookie `token_webapps`.
You should have serve package to run in production mode.
Add the following script in `package.json`:

```bash
{
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "start": "serve -s dist -l 3000"
  }
}
```

## Authentication

You should create Login page to get JWT token.
Login page have username and password field.
When user submit the form, you need make a POST request to the following endpoint:

```bash
curl -X POST "https://LOGIN_DOMAIN_HERE/login/" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "action=staff_login&username=YOUR_USERNAME&pass_admin=YOUR_PASSWORD&is_json=1&is_webapps=1"
```

The response will contain a JSON object with a `token` field. Save this token as a cookie named `token_webapps` for future requests.

To authenticate your requests, you need to include a JWT token in the `Authorization` header of your HTTP requests. The token should be prefixed with the word "Bearer". For example:
```Authorization: Bearer YOUR_JWT_TOKEN```

To obtain a JWT token, check the cookie named `token_webapps` after logging into the platform.

## API to generateContent

Depending on your needs, you can use model `gemini-3-pro-preview` for text generation or `gemini-2.5-flash-image` for image-related tasks.
If you use `gemini-3-pro-preview`, you should consider use thinking config with "low" or "high".
Document config here <https://ai.google.dev/gemini-api/docs/gemini-3>
Example of config for thinking:

```json
{
  config: {
      thinkingConfig: {
        thinkingLevel: "low",
      }
    }
}
```

If you use generate image, Document config here <https://ai.google.dev/gemini-api/docs/image-generation>

To generate content using the API, you need to make a POST request to the following endpoint:

```bash
curl -X POST "https://BACKEND_DOMAIN_HERE/api/generateContent" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "model": "gemini-2.5-flash-image",
    "contents": {
      "parts": [
        {
          "inlineData": {
            "mimeType": "image/jpeg",
            "data": "BASE64_ENCODED_IMAGE_DATA_HERE"
          }
        },
        {
          "text": "Describe this prompt in a creative way."
        }
      ]
    }
  }'
```
