From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 12/25] i915: switch from acpi_os_ioremap to
	ioremap
Date: Fri, 24 Jul 2015 22:39:04 -0400
Message-ID: <20150725023904.8664.84461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, toshi.kani@hp.com, linux-nvdimm@lists.01.org, David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, rmk+kernel@arm.linux.org.uk, hch@lst.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

YWNwaV9vc19pb3JlbWFwIHVzZXMgY2FjaGVkIG1hcHBpbmdzLCBob3dldmVyIGl0IGFwcGVhcnMg
dGhhdCBpOTE1CndhbnRzIHRvIHJlYWQgZHluYW1pYyBwbGF0Zm9ybSBzdGF0ZS4gIFN3aXRjaCB0
byBpb3JlbWFwKCkgdG8gcHJldmVudCBpdApyZWFkaW5nIHN0YWxlIHN0YXRlIGZyb20gY2FjaGUu
CgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBpbnRlbC5jb20+CkNjOiBKYW5pIE5p
a3VsYSA8amFuaS5uaWt1bGFAbGludXguaW50ZWwuY29tPgpDYzogaW50ZWwtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMg
PGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRl
bF9vcHJlZ2lvbi5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfb3By
ZWdpb24uYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX29wcmVnaW9uLmMKaW5kZXggNDgx
MzM3NDM2ZjcyLi4xNmJhN2M2NzQxMGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2ludGVsX29wcmVnaW9uLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfb3ByZWdp
b24uYwpAQCAtODYzLDcgKzg2Myw3IEBAIGludCBpbnRlbF9vcHJlZ2lvbl9zZXR1cChzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2KQogCUlOSVRfV09SSygmb3ByZWdpb24tPmFzbGVfd29yaywgYXNsZV93
b3JrKTsKICNlbmRpZgogCi0JYmFzZSA9IGFjcGlfb3NfaW9yZW1hcChhc2xzLCBPUFJFR0lPTl9T
SVpFKTsKKwliYXNlID0gaW9yZW1hcChhc2xzLCBPUFJFR0lPTl9TSVpFKTsKIAlpZiAoIWJhc2Up
CiAJCXJldHVybiAtRU5PTUVNOwogCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2ludGVsLWdmeAo=
