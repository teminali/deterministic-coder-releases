# Deterministic Coder on Google Colab (experimental)

[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/teminali/deterministic-coder-releases/blob/main/colab/deterministic_coder_server.ipynb)

A notebook that serves a coding model on a Colab GPU **you** pick and joins **your own** Tailscale network, so Deterministic Coder can use it from Settings > Local AI server. Nothing is exposed to the public internet, and Deterministic Coder never holds your Google or Tailscale credentials.

**Status: experimental. This notebook has not yet been verified on a live Colab runtime.** Treat every row below as unproven until someone runs it. If a cell fails, the error message is the useful part; issues are welcome.

| GPU (Colab) | Model | Context | Download |
|---|---|---|---|
| A100 or H100, 80 GB (Colab Pro / Pro+) | `Qwen/Qwen3.8-27B` (bf16) | 131072 | ~55.6 GB |
| A100, 40 GB (Colab Pro / Pro+) | `Qwen/Qwen3.8-27B-FP8` | 32768 | ~30.9 GB |
| L4, 24 GB (Colab Pro / Pro+) | `Qwen/Qwen2.5-Coder-14B-Instruct-AWQ` (4-bit) | 32768 | ~10 GB |
| T4, 16 GB (free) | `Qwen/Qwen2.5-Coder-14B-Instruct-AWQ` (4-bit) | 8192 | ~10 GB |

The 27B model needs a GPU of at least 38 GB, so smaller GPUs use the 14B 4-bit model. Paid GPUs are not guaranteed to be available.

## Steps

1. Install Tailscale on the computer that runs Deterministic Coder and sign in.
2. In the Tailscale admin page create an auth key (reusable and ephemeral).
3. In Colab add it as a secret named `TS_AUTHKEY` with Notebook access on, pick a GPU, and choose Runtime > Run all.
4. Paste the address and key the last cell prints into Deterministic Coder (Settings > Local AI server, "Colab GPU" guide) and tick "This server is on my network".

Each Colab session can have a new address and key, so paste them again if you restart the notebook. A free runtime can disconnect when idle.

## Terms and privacy

- Google's Colab terms limit what notebooks may be used for, including serving models to other machines. This is for your own use on your own Colab account; you are responsible for staying within Google's terms. Do not share the address or the key.
- Your prompts and code leave your computer and are processed on Google's servers. This is not offline.
- **Clear outputs before sharing a copy of the notebook:** it prints a session API key.
- An optional Google Drive cache (off by default) can keep the model files in your own Drive so later sessions skip the download. A free Google account has 15 GB shared with Gmail and Photos, so only the 14B model can fit there, and only with about 11 GB free.
