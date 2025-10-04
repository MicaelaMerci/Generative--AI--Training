
py_import os, litellm;

walker GeminiCalcWalker {
    can ask_question as entry {
        print("Enter your question (e.g., 'What is 5 + 7?' or 'If I was born in 1990, how old am I?'):");
        question = input();
        api_key = py_call(os.getenv, "GEMINI_API_KEY");
        if api_key == None {
            print("Error: GEMINI_API_KEY environment variable not set.");
            return;
        }
        try {
            response = py_call(litellm.completion, {
                "model": "gemini-pro",
                "messages": [{"role": "user", "content": question}],
                "api_key": api_key
            });
            print("Gemini AI says:", response["choices"][0]["message"]["content"]);
        } catch(e) {
            print("Error communicating with Gemini AI:", e);
        }
    }
}

spawn GeminiCalcWalker.ask_question;
