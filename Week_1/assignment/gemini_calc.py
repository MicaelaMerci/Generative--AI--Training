import os
import litellm

def main():
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        print("Error: GEMINI_API_KEY environment variable not set.")
        return
    question = input("Enter your question (e.g., 'What is 5 + 7?' or 'If I was born in 1990, how old am I?'): ")
    try:
        response = litellm.completion(
            model="gemini-pro",
            messages=[{"role": "user", "content": question}],
            api_key=api_key
        )
        print("Gemini AI says:", response["choices"][0]["message"]["content"])
    except Exception as e:
        print("Error communicating with Gemini AI:", e)

if __name__ == "__main__":
    main()
