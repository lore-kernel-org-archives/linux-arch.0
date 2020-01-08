From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Date: Wed, 8 Jan 2020 09:35:54 +0100
Message-ID: <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
 <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
 <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com>
Content-Language: fr
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Jason Wang <jasowang@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jon
List-Id: linux-arch.vger.kernel.org

CgpMZSAwOC8wMS8yMDIwIMOgIDA5OjE4LCBLcnp5c3p0b2YgS296bG93c2tpIGEgw6ljcml0wqA6
Cj4gT24gV2VkLCA4IEphbiAyMDIwIGF0IDA5OjEzLCBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
QGxpbnV4LW02OGsub3JnPiB3cm90ZToKPj4KPj4gSGkgS3J6eXN6dG9mLAo+Pgo+PiBPbiBXZWQs
IEphbiA4LCAyMDIwIGF0IDk6MDcgQU0gR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1t
NjhrLm9yZz4gd3JvdGU6Cj4+PiBPbiBUdWUsIEphbiA3LCAyMDIwIGF0IDU6NTMgUE0gS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiB3cm90ZToKPj4+PiBUaGUgaW9yZWFkOC8x
Ni8zMigpIGFuZCBvdGhlcnMgaGF2ZSBpbmNvbnNpc3RlbnQgaW50ZXJmYWNlIGFtb25nIHRoZQo+
Pj4+IGFyY2hpdGVjdHVyZXM6IHNvbWUgdGFraW5nIGFkZHJlc3MgYXMgY29uc3QsIHNvbWUgbm90
Lgo+Pj4+Cj4+Pj4gSXQgc2VlbXMgdGhlcmUgaXMgbm90aGluZyByZWFsbHkgc3RvcHBpbmcgYWxs
IG9mIHRoZW0gdG8gdGFrZQo+Pj4+IHBvaW50ZXIgdG8gY29uc3QuCj4+Pgo+Pj4gU2hvdWxkbid0
IGFsbCBvZiB0aGVtIHRha2UgY29uc3Qgdm9sYXRpbGUgX19pb21lbSBwb2ludGVycz8KPj4+IEl0
IHNlZW1zIHRoZSAidm9sYXRpbGUiIGlzIG1pc3NpbmcgZnJvbSBhbGwgYnV0IHRoZSBpbXBsZW1l
bnRhdGlvbnMgaW4KPj4+IGluY2x1ZGUvYXNtLWdlbmVyaWMvaW8uaC4KPj4KPj4gQXMgbXkgInZv
bGF0aWxlIiBjb21tZW50IGFwcGxpZXMgdG8gaW93cml0ZSooKSwgdG9vLCBwcm9iYWJseSB0aGF0
IHNob3VsZCBiZQo+PiBkb25lIGluIGEgc2VwYXJhdGUgcGF0Y2guCj4+Cj4+IEhlbmNlIHdpdGgg
cGF0Y2hlcyAxLTUgc3F1YXNoZWQsIGFuZCBmb3IgcGF0Y2hlcyAxMS0xMzoKPj4gUmV2aWV3ZWQt
Ynk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+Cj4gCj4gSSds
bCBhZGQgdG8gdGhpcyBvbmUgYWxzbyBjaGFuZ2VzIHRvIGlvcmVhZFhfcmVwKCkgYW5kIGFkZCBh
bm90aGVyCj4gcGF0Y2ggZm9yIHZvbGF0aWxlIGZvciByZWFkcyBhbmQgd3JpdGVzLiBJIGd1ZXNz
IHlvdXIgcmV2aWV3IHdpbGwgYmUKPiBhcHByZWNpYXRlZCBvbmNlIG1vcmUgYmVjYXVzZSBvZiBp
b3JlYWRYX3JlcCgpCj4gCgp2b2xhdGlsZSBzaG91bGQgcmVhbGx5IG9ubHkgYmUgdXNlZCB3aGVy
ZSBkZWVtZWQgbmVjZXNzYXJ5OgoKaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRl
c3QvcHJvY2Vzcy92b2xhdGlsZS1jb25zaWRlcmVkLWhhcm1mdWwuaHRtbAoKSXQgaXMgc2FpZDog
IiAuLi4gIGFjY2Vzc29yIGZ1bmN0aW9ucyBtaWdodCB1c2Ugdm9sYXRpbGUgb24gCmFyY2hpdGVj
dHVyZXMgd2hlcmUgZGlyZWN0IEkvTyBtZW1vcnkgYWNjZXNzIGRvZXMgd29yay4gRXNzZW50aWFs
bHksIAplYWNoIGFjY2Vzc29yIGNhbGwgYmVjb21lcyBhIGxpdHRsZSBjcml0aWNhbCBzZWN0aW9u
IG9uIGl0cyBvd24gYW5kIAplbnN1cmVzIHRoYXQgdGhlIGFjY2VzcyBoYXBwZW5zIGFzIGV4cGVj
dGVkIGJ5IHRoZSBwcm9ncmFtbWVyLiIKCkNocmlzdG9waGUKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXNucHMtYXJjIG1haWxpbmcgbGlzdAps
aW51eC1zbnBzLWFyY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtc25wcy1hcmMK
