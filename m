From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 09/14] jump_label: port __jump_table to
	linker tables
Date: Tue, 3 Jan 2017 22:27:44 +0100
Message-ID: <20170103212744.GF13946@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
 <20161222023811.21246-10-mcgrof@kernel.org>
 <1482415702.9552.125.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <1482415702.9552.125.camel@linux.intel.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gnomes@lxorguk.ukuu.org.uk, dalias@libc.org, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, mpe@ellerman.id.au, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, wangnan0@huawei.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, will.deacon@arm.com, korea.drzix@gmail.com, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, dsahern@gmail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, linux@roeck-us.net, david.vrabel@citrix.com, linux-xte
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCBEZWMgMjIsIDIwMTYgYXQgMDQ6MDg6MjJQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOgo+IE9uIFdlZCwgMjAxNi0xMi0yMSBhdCAxODozOCAtMDgwMCwgTHVpcyBSLiBSb2Ry
aWd1ZXogd3JvdGU6Cj4gPiBNb3ZlIHRoZSBfX2p1bXBfdGFibGUgZnJvbSB0aGUgYSBjdXN0b20g
c2VjdGlvbiBzb2x1dGlvbgo+ID4gdG8gYSBnZW5lcmljIHNvbHV0aW9uLCB0aGlzIGF2b2lkaW5n
IGV4dHJhIHZtbGludXgubGRzLmgKPiA+IGN1c3RvbWl6YXRpb25zLgo+ID4gCj4gPiBUaGlzIGFs
c28gZGVtb3MgdGhlIHVzZSBvZiB0aGUgLmRhdGEgbGlua2VyIHRhYmxlIGFuZCBvZgo+ID4gdGhl
IHNoYXJlZCBhc20gY2FsbCBwdXNoX3NlY3Rpb25fdGJsKCkuCj4gPiAKPiAKPiA+IMKgewo+ID4g
wqAJYXNtX3ZvbGF0aWxlX2dvdG8oIjE6XG5cdCIKPiA+IMKgCQnCoFdBU00obm9wKSAiXG5cdCIK
PiA+IC0JCcKgIi5wdXNoc2VjdGlvbiBfX2p1bXBfdGFibGUswqDCoFwiYXdcIlxuXHQiCj4gPiAr
CQnCoHB1c2hfc2VjdGlvbl90YmxfYW55KC5kYXRhLCBfX2p1bXBfdGFibGUsIGF3KQo+ID4gwqAJ
CcKgIi53b3JkIDFiLCAlbFtsX3llc10sICVjMFxuXHQiCj4gPiDCoAkJwqAiLnBvcHNlY3Rpb25c
blx0Igo+ID4gwqAJCcKgOiA6wqDCoCJpIiAoJigoY2hhciAqKWtleSlbYnJhbmNoXSkgOsKgwqA6
IGxfeWVzKTsKPiA+IEBAIC0yNiw3ICsyOCw3IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9v
bAo+ID4gYXJjaF9zdGF0aWNfYnJhbmNoX2p1bXAoc3RydWN0IHN0YXRpY19rZXkgKmtleSwgYm9v
bAo+ID4gwqB7Cj4gPiDCoAlhc21fdm9sYXRpbGVfZ290bygiMTpcblx0Igo+ID4gwqAJCcKgV0FT
TShiKSAiICVsW2xfeWVzXVxuXHQiCj4gPiAtCQnCoCIucHVzaHNlY3Rpb24gX19qdW1wX3RhYmxl
LMKgwqBcImF3XCJcblx0Igo+ID4gKwkJwqBwdXNoX3NlY3Rpb25fdGJsX2FueSguZGF0YSwgX19q
dW1wX3RhYmxlLCBhdykKPiA+IMKgCQnCoCIud29yZCAxYiwgJWxbbF95ZXNdLCAlYzBcblx0Igo+
ID4gwqAJCcKgIi5wb3BzZWN0aW9uXG5cdCIKPiAKPiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gaW50
cm9kdWNlIHNvbWV0aGluZyBsaWtlCj4gCj4gI2RlZmluZSBwb3Bfc2VjdGlvbl90YmwgIi5wb3Bz
ZWN0aW9uXG5cdCIKPiAjZGVmaW5lIHBvcF9zZWN0aW9uX3RibF9hbnkgcG9wX3NlY3Rpb25fdGJs
CgpBYnNvbHV0ZWx5ICEgSG93ZXZlciB0aGlzIHdvdWxkIGJlIGFuIGV2b2x1dGlvbiwgYW5kIEkg
d291bGQgbXVjaApwcmVmZXIgdG8gYWRkIHRoaXMgbGF0ZXIgYXMgYW4gYXRvbWljIHN0ZXAgbGF0
ZXIgdG8gZW5hYmxlIG90aGVyCnVzZXJzIHRvIGFsc28gYmUgdXNpbmcgdGhpcyBzaGFyZWQgbWFj
cm8uIEkgZGlkIG5vdCBoYXZlIGFuIGltbWVkaWF0ZQpuZWVkIGZvciBhIHBvcF9zZWN0aW9uX3Ri
bCgpIG1hY3JvIGFzIGl0cyBub3Qgc2VjdGlvbiBzcGVjaWZpYy4KCiAgTHVpcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcg
bGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5vcmcveGVuLWRl
dmVsCg==
