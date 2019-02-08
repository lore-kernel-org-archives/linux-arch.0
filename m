From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] drm: tweak header name
Date: Fri, 8 Feb 2019 07:55:32 -0500
Message-ID: <20190208075408-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-4-mst@redhat.com>
 <20190208085659.GI23159@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190208085659.GI23159@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBGZWIgMDgsIDIwMTkgYXQgMDk6NTY6NTlBTSArMDEwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBGcmksIEZlYiAwOCwgMjAxOSBhdCAwMTowMjo1OEFNIC0wNTAwLCBNaWNoYWVs
IFMuIFRzaXJraW4gd3JvdGU6Cj4gPiBVc2UgbGludXgvbW1hbi5oIHRvIG1ha2Ugc3VyZSB3ZSBn
ZXQgYWxsIG1tYXAgZmxhZ3Mgd2UgbmVlZC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiAKPiBkcm1QLmggaXMgc2VyaW91c2x5IGRl
cHJlY2F0ZWQgKGFuZCBhIG1vbnN0ZXIgbWVzcykuIElmIHRoaXMgZml4ZXMKPiBhbnl0aGluZywg
SSB0aGluayB3b3VsZCBiZSBiZXR0ZXIgdG8gaW5jbHVkZSB0aGUgcmlnaHQgaGVhZGVyIGluIHRo
ZSByaWdodAo+IHBsYWNlcywgYW5kIGxlYXZlIGRybVAuaCB0byBkaWUgcXVpZXRseSAuLi4KPiAK
PiBXaGF0IGV4YWN0bHkgZG9lcyB0aGlzIGZpeD8KPiAtRGFuaWVsCgpJIGRvbid0IGtub3cuIEkg
YW0gbW92aW5nIGZsYWdzIGZyb20gYXNtL21tYW4uaCBhbmQgaWYgdGhlcmUKYXJlIGRpcmVjdCB1
c2VycyB3aGljaCB0aGVyZSBzaG91bGQgbm90IGJlLCBzb21lIGNvZGUKbWlnaHQgYnJlYWsuIEV2
ZW4gaWYgaXQncyBhIGJhZCBoZWFkZXIgcGVvcGxlIGNvcHkKY29kZSBhcm91bmQsIHNvIHdoeSBs
ZWF2ZSB3cm9uZyBleGFtcGxlcyB0aGVyZT8KV2hhdCdzIHRoZSBoYXJtIGluIGJlaW5nIHByb2Fj
dGl2ZT8KCgo+ID4gLS0tCj4gPiAgaW5jbHVkZS9kcm0vZHJtUC5oIHwgMyArLS0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2RybS9kcm1QLmggYi9pbmNsdWRlL2RybS9kcm1QLmgKPiA+IGluZGV4
IGJkYjBkNTU0OGYzOS4uYTMxODQ0MTZkZGM1IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9kcm0v
ZHJtUC5oCj4gPiArKysgYi9pbmNsdWRlL2RybS9kcm1QLmgKPiA+IEBAIC01Nyw4ICs1Nyw3IEBA
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9k
bWEtZmVuY2UuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gPiAtCj4gPiAtI2lu
Y2x1ZGUgPGFzbS9tbWFuLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L21tYW4uaD4KPiA+ICAjaW5j
bHVkZSA8YXNtL3BnYWxsb2MuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgo+ID4g
IAo+ID4gLS0gCj4gPiBNU1QKPiA+IAo+IAo+IC0tIAo+IERhbmllbCBWZXR0ZXIKPiBTb2Z0d2Fy
ZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KPiBodHRwOi8vYmxvZy5mZndsbC5jaApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
