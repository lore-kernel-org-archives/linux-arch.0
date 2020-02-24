From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND PATCH v2 9/9] ath5k: Constify ioreadX() iomem argument
 (as in generic implementation)
Date: Mon, 24 Feb 2020 13:54:00 +0100
Message-ID: <CAMuHMdVev0PLF=8bD3nHrhcU9UgM-DAgdQpXi09PgvAxdbt24A@mail.gmail.com>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-10-krzk@kernel.org>
 <518a9023-f802-17b3-fca5-582400bc34ae@gmail.com> <20200224124744.GA1949@pi3>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200224124744.GA1949@pi3>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Wang <jasowang@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, netdev <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Matt Turner <matt>
List-Id: linux-arch.vger.kernel.org

SGkgS3J6eXN6dG9mLAoKT24gTW9uLCBGZWIgMjQsIDIwMjAgYXQgMTo0NyBQTSBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+IHdyb3RlOgo+IE9uIFRodSwgRmViIDIwLCAyMDIw
IGF0IDEwOjQ4OjMzQU0gKzAxMDAsIEppcmkgU2xhYnkgd3JvdGU6Cj4gPiBPbiAxOS4gMDIuIDIw
LCAxODo1MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToKPiA+ID4gVGhlIGlvcmVhZFgoKSBo
ZWxwZXJzIGhhdmUgaW5jb25zaXN0ZW50IGludGVyZmFjZS4gIE9uIHNvbWUgYXJjaGl0ZWN0dXJl
cwo+ID4gPiB2b2lkICpfX2lvbWVtIGFkZHJlc3MgYXJndW1lbnQgaXMgYSBwb2ludGVyIHRvIGNv
bnN0LCBvbiBzb21lIG5vdC4KPiA+ID4KPiA+ID4gSW1wbGVtZW50YXRpb25zIG9mIGlvcmVhZFgo
KSBkbyBub3QgbW9kaWZ5IHRoZSBtZW1vcnkgdW5kZXIgdGhlIGFkZHJlc3MKPiA+ID4gc28gdGhl
eSBjYW4gYmUgY29udmVydGVkIHRvIGEgImNvbnN0IiB2ZXJzaW9uIGZvciBjb25zdC1zYWZldHkg
YW5kCj4gPiA+IGNvbnNpc3RlbmN5IGFtb25nIGFyY2hpdGVjdHVyZXMuCj4gPiA+Cj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4KPiA+ID4g
QWNrZWQtYnk6IEthbGxlIFZhbG8gPGt2YWxvQGNvZGVhdXJvcmEub3JnPgo+ID4gPiAtLS0KPiA+
ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg1ay9haGIuYyB8IDEwICsrKysrLS0tLS0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4g
PiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoNWsvYWhi
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoNWsvYWhiLmMKPiA+ID4gaW5kZXggMmM5
Y2VjOGI1M2Q5Li44YmQwMWRmMzY5ZmIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL2F0aC9hdGg1ay9haGIuYwo+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9h
dGgvYXRoNWsvYWhiLmMKPiA+ID4gQEAgLTEzOCwxOCArMTM4LDE4IEBAIHN0YXRpYyBpbnQgYXRo
X2FoYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gPgo+ID4gPiAgICAg
aWYgKGJjZmctPmRldmlkID49IEFSNUtfU1JFVl9BUjIzMTVfUjYpIHsKPiA+ID4gICAgICAgICAg
ICAgLyogRW5hYmxlIFdNQUMgQUhCIGFyYml0cmF0aW9uICovCj4gPiA+IC0gICAgICAgICAgIHJl
ZyA9IGlvcmVhZDMyKCh2b2lkIF9faW9tZW0gKikgQVI1S19BUjIzMTVfQUhCX0FSQl9DVEwpOwo+
ID4gPiArICAgICAgICAgICByZWcgPSBpb3JlYWQzMigoY29uc3Qgdm9pZCBfX2lvbWVtICopIEFS
NUtfQVIyMzE1X0FIQl9BUkJfQ1RMKTsKPiA+Cj4gPiBXaGlsZSBJIHVuZGVyc3RhbmQgd2h5IHRo
ZSBwYXJhbWV0ZXIgb2YgaW9yZWFkMzIgc2hvdWxkIGJlIGNvbnN0LCBJCj4gPiBkb24ndCBzZWUg
YSByZWFzb24gZm9yIHRoZXNlIGNhc3RzIG9uIHRoZSB1c2Vycycgc2lkZS4gV2hhdCBkb2VzIGl0
Cj4gPiBicmluZyBleGNlcHQgbG9uZ2VyIGNvZGUgdG8gcmVhZD8KPgo+IEJlY2F1c2UgdGhlIGFy
Z3VtZW50IGlzIGFuIGludDoKPgo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg1ay9haGIu
YzogSW4gZnVuY3Rpb24g4oCYYXRoX2FoYl9wcm9iZeKAmToKPiBkcml2ZXJzL25ldC93aXJlbGVz
cy9hdGgvYXRoNWsvYWhiLmM6MTQxOjE4OiB3YXJuaW5nOiBwYXNzaW5nIGFyZ3VtZW50IDEgb2Yg
4oCYaW9yZWFkMzLigJkgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3Qg
Wy1XaW50LWNvbnZlcnNpb25dCj4gICAgcmVnID0gaW9yZWFkMzIoQVI1S19BUjIzMTVfQUhCX0FS
Ql9DVEwpOwoKVGhhdCdzIGFuIGFyZ3VtZW50IGZvciBrZWVwaW5nIHRoZSBjYXN0IHRvICJ2b2lk
IF9faW9tZW0gKiIsIG5vdCBmb3IKYWRkaW5nIHRoZSAiY29uc3QiLCByaWdodD8KCkdye29ldGpl
LGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0
ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxp
bnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBl
b3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91
cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtc25wcy1hcmMg
bWFpbGluZyBsaXN0CmxpbnV4LXNucHMtYXJjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1zbnBzLWFyYwo=
