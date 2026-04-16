# Custom Domain Setup for AgentRail

Current stable host:
- https://bluemarlin1999.github.io/agentrail-public-assets/

Chosen custom domain:
- https://agentrail.tech/

Repository-side setup is now prepared with `docs/CNAME = agentrail.tech`.

To finish the cutover:
1. Open your DNS provider for `agentrail.tech`
2. If your provider supports apex flattening / ALIAS / ANAME, point the root domain to `BlueMarlin1999.github.io`
3. If you use standard GitHub Pages apex setup, add these A records:
   - `185.199.108.153`
   - `185.199.109.153`
   - `185.199.110.153`
   - `185.199.111.153`
4. Optional but recommended: add `www` as `CNAME -> BlueMarlin1999.github.io`
5. Wait for DNS propagation
6. Verify these paths:
   - `/agentrail-install.html`
   - `/install-online.sh`
   - `/release.html`
   - `/pricing.html`

If you later decide to move downloads to a subdomain such as `download.agentrail.tech`, replace the CNAME file accordingly and point that hostname to `BlueMarlin1999.github.io`.
