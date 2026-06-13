"""
DeepSeek API Controller Tuning for Buck-Boost Converter
Uses LLM to intelligently suggest PID gains based on simulation results
"""

import os
import time
from dotenv import load_dotenv
from openai import OpenAI

# Load API key from .env file
load_dotenv()

# Initialize DeepSeek client
client = OpenAI(
    api_key=os.getenv("DEEPSEEK_API_KEY"),
    base_url=os.getenv("DEEPSEEK_BASE_URL", "https://api.deepseek.com")
)

def get_tuning_suggestion(history, current_metrics):
    """
    Ask DeepSeek API for next PID gain values
    
    Parameters:
    - history: List of previous attempts and results
    - current_metrics: Dict with kp, ki, overshoot, settling_time, error
    
    Returns:
    - Dictionary with suggested kp, ki and reasoning
    """
    
    prompt = f"""
You are an expert control systems engineer tuning a PID controller for a buck-boost converter.

SYSTEM SPECS:
- Input: 12V DC
- Output range: 5V to 15V
- Switching frequency: 50 kHz
- Plant: Non-linear buck-boost topology

TARGET PERFORMANCE:
- Overshoot: <5%
- Settling time: <5ms
- Steady-state error: <0.01V

PREVIOUS ATTEMPTS:
{chr(10).join(history[-5:]) if history else "No previous attempts"}

CURRENT GAINS:
Kp = {current_metrics['kp']}
Ki = {current_metrics['ki']}

CURRENT PERFORMANCE:
Overshoot: {current_metrics['overshoot']}%
Settling time: {current_metrics['settling_time']}ms
Steady-state error: {current_metrics['steady_state_error']}V

Based on this information, suggest the NEXT Kp and Ki values to try.
Explain your reasoning briefly.

RESPOND IN THIS EXACT FORMAT:
KP: [number]
KI: [number]
REASONING: [your explanation]
"""
    
    response = client.chat.completions.create(
        model="deepseek-chat",
        messages=[
            {"role": "system", "content": "You are an expert control systems engineer. Provide precise numerical suggestions."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.6
    )
    
    return response.choices[0].message.content

def parse_suggestion(response_text):
    """Extract Kp and Ki from API response"""
    lines = response_text.strip().split('\n')
    kp = None
    ki = None
    reasoning = ""
    
    for line in lines:
        if line.startswith("KP:"):
            kp = float(line.split(":")[1].strip())
        elif line.startswith("KI:"):
            ki = float(line.split(":")[1].strip())
        elif line.startswith("REASONING:"):
            reasoning = line.split(":", 1)[1].strip()
    
    return kp, ki, reasoning

# Example usage
if __name__ == "__main__":
    # Example: Simulated tuning session
    history = []
    current = {
        'kp': 1.5,
        'ki': 0.4,
        'overshoot': 12.5,
        'settling_time': 8.2,
        'steady_state_error': 0.02
    }
    
    print("🤖 Contacting DeepSeek API for tuning suggestions...")
    suggestion = get_tuning_suggestion(history, current)
    kp, ki, reason = parse_suggestion(suggestion)
    
    print(f"\n📊 Suggestion received:")
    print(f"   Kp = {kp}")
    print(f"   Ki = {ki}")
    print(f"\n💡 Reasoning: {reason}")