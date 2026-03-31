bluetooth_policy = bluetooth_policy or {}
bluetooth_policy.policy = bluetooth_policy.policy or {}

-- Keep Bluetooth headphones on the high-fidelity A2DP profile unless we
-- explicitly switch to a headset profile. This avoids surprise quality drops
-- when apps open a microphone stream.
bluetooth_policy.policy["media-role.use-headset-profile"] = false
