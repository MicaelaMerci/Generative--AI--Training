walker GeminiCalcWalker {
    can ask_question as entry {
        print("Enter your question (e.g., 'What is 5 + 7?' or 'If I was born in 1990, how old am I?'):");
        question = input();
        response = py:call_gemini(question);
        print("Gemini AI says:", response);
    }
}

py def call_gemini(question):
    import os
    import litellm
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        return "Error: GEMINI_API_KEY environment variable not set."
    try:
        result = litellm.completion(
            model="gemini-pro",
            messages=[{"role": "user", "content": question}],
            api_key=api_key
        )
        return result["choices"][0]["message"]["content"]
    except Exception as e:
        return f"Error communicating with Gemini AI: {e}"

spawn GeminiCalcWalker.ask_question;
