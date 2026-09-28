# Shared AI scratch environment

This is the stable Python environment for ad hoc analysis performed by Codex,
Claude, and other local agents. It covers plotting, tabular analysis, image and
video inspection, MCAP/ROS bag decoding, notebooks, and lightweight testing.

Use the direct interpreter wrapper from any working directory:

```bash
~/.agent_files/tooling/ai-scratch/bin/ai-python script.py
```

The convenience command is also installed on the normal user `PATH`:

```bash
ai-python script.py
```

For an interactive shell, source `load.sh`. To reproduce the environment after
changing `pyproject.toml`, run `uv lock` and then `bin/bootstrap`.

Runtime caches default to `${TMPDIR:-/tmp}/ai-scratch-cache-$UID`. This keeps
Matplotlib, fontconfig, and uv writable in sandboxed agent sessions even though
the shared environment itself is intentionally read-only during normal use.

Do not install repository code, ROS, Torch, MuJoCo, Isaac, or other project
runtimes here. Use each repository's documented uv, veneer, Conda, or ROS
workspace for repository tests and runtime work. This separation prevents the
scratch environment from masking missing project dependencies or stale editable
installs.
