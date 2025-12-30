# HY-Motion-1.0 - RunPod A40 Setup

This fork includes optimizations for running on RunPod with an A40 GPU (48GB VRAM).

## Quick Start on RunPod

```bash
cd /workspace
git clone https://github.com/kvick-games/HY-Motion-1.0_Runpod_A40.git
cd HY-Motion-1.0_Runpod_A40
pip install -r requirements.txt
pip install gradio
apt-get update && apt-get install -y git-lfs
git lfs pull
./run_gradio.sh
```

## What's Different from Upstream

1. **Skips the 62GB Text2MotionPrompter model** - The original repo downloads a massive LLM for prompt rewriting and duration estimation. This fork disables it by default, saving ~62GB of downloads and letting you run with just the core motion model.

2. **Downloads go to /workspace** - HuggingFace cache is redirected to `/workspace/hf_cache` to avoid filling up the small root disk on RunPod.

3. **Share URL enabled** - Gradio launches with a public share URL so you can access the UI from your browser.

## Usage

### Option 1: Use the wrapper script (recommended)
```bash
./run_gradio.sh
```

### Option 2: Run directly with env var
```bash
DISABLE_PROMPT_ENGINEERING=1 python3 gradio_app.py
```

## Models Downloaded

- **HY-Motion-1.0-Lite** (~1.8GB) - The motion generation model
- **Qwen3-8B** (~15GB) - Text encoder (required, downloaded automatically on first run)
- **CLIP** (~1.6GB) - Vision/text encoder

Total: ~18GB (vs ~80GB with the full text prompter)

## Notes

- First run will download the Qwen3 text encoder (~15GB) - this is required and can't be skipped
- Without the prompter, you write your own prompts (no auto-rewrite) and set duration manually
- The core motion generation works identically
