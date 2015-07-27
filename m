From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH v2 12/25] i915: switch from acpi_os_ioremap
 to ioremap
Date: Mon, 27 Jul 2015 09:50:50 +0200
Message-ID: <20150727075050.GK16722@phenom.ffwll.local>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023904.8664.84461.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20150725023904.8664.84461.stgit@dwillia2-desk3.amr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-arch@vger.kernel.org, toshi.kani@hp.com, linux-nvdimm@lists.01.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de, hpa@zytor.com, rmk+kernel@arm.linux.org.uk, Daniel Vetter <daniel.vetter@intel.com>, tglx@linutronix.de, mingo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBKdWwgMjQsIDIwMTUgYXQgMTA6Mzk6MDRQTSAtMDQwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOgo+IGFjcGlfb3NfaW9yZW1hcCB1c2VzIGNhY2hlZCBtYXBwaW5ncywgaG93ZXZlciBpdCBh
cHBlYXJzIHRoYXQgaTkxNQo+IHdhbnRzIHRvIHJlYWQgZHluYW1pYyBwbGF0Zm9ybSBzdGF0ZS4g
IFN3aXRjaCB0byBpb3JlbWFwKCkgdG8gcHJldmVudCBpdAo+IHJlYWRpbmcgc3RhbGUgc3RhdGUg
ZnJvbSBjYWNoZS4KPiAKPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBpbnRlbC5j
b20+Cj4gQ2M6IEphbmkgTmlrdWxhIDxqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5jb20+Cj4gQ2M6
IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPgo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2ln
bmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+Cj4gLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX29wcmVnaW9uLmMgfCAgICAyICstCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9vcHJlZ2lvbi5jIGIvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvaW50ZWxfb3ByZWdpb24uYwo+IGluZGV4IDQ4MTMzNzQzNmY3Mi4uMTZiYTdjNjc0
MTBkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX29wcmVnaW9uLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9vcHJlZ2lvbi5jCj4gQEAgLTg2Myw3
ICs4NjMsNyBAQCBpbnQgaW50ZWxfb3ByZWdpb25fc2V0dXAoc3RydWN0IGRybV9kZXZpY2UgKmRl
dikKPiAgCUlOSVRfV09SSygmb3ByZWdpb24tPmFzbGVfd29yaywgYXNsZV93b3JrKTsKPiAgI2Vu
ZGlmCj4gIAo+IC0JYmFzZSA9IGFjcGlfb3NfaW9yZW1hcChhc2xzLCBPUFJFR0lPTl9TSVpFKTsK
PiArCWJhc2UgPSBpb3JlbWFwKGFzbHMsIE9QUkVHSU9OX1NJWkUpOwoKT3BSZWdpb24gaXMgY2Fj
aGVkIG1lbW9yeSBzaGFyZWQgd2l0aCB0aGUgZmlybXdhcmUgYWZhaWssIHdlIHByb2JhYmx5IHdh
bnQKYSBtZW1yZW1hcCBoZXJlIGFuZCBzd2l0Y2ggYXdheSBmcm9tIHRoZSBpb3JlYWQvd3JpdGUg
c3R1ZmYuIFdlIGhhdmUgYQpzaW1pbGFyIGNvbmZ1c2lvbiBnb2luZyBvbiBmb3IgdGhlIHZidCBw
YXJzaW5nICh3aGljaCBvbiBhbnl0aGluZyBidXQKcmVhbGx5IG9sZCBtYWNoaW5lcyBpcyBhbHNv
IGp1c3Qgbm9ybWFsIG1lbW9yeSkuCgpTYW1lIGhvbGRzIGZvciBnbWE1MDAsIHdoaWNoIGlzIGp1
c3QgYSBjb3B5IG9mIGk5MTUgZm9yIHNvbWUgc3BlY2lhbApwbGF0Zm9ybXMuCi1EYW5pZWwKLS0g
CkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6
Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==
