# Custom Domain Setup for AgentRail

Current stable host:
- https://bluemarlin1999.github.io/agentrail-public-assets/

To switch to your own domain later:
1. Choose a hostname, for example `download.agentrail.ai`
2. Copy `docs/CNAME.example` to `docs/CNAME`
3. Replace the content with your real hostname
4. In DNS, point the hostname to GitHub Pages
5. Verify these paths after propagation:
   - `/agentrail-install.html`
   - `/install-online.sh`
   - GitHub release download links

Recommended DNS records for GitHub Pages:
- `CNAME download -> BlueMarlin1999.github.io`

If you want apex/root-domain hosting instead of a subdomain, use ALIAS/ANAME support from your DNS provider.
