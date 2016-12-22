From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 09/14] jump_label: port __jump_table to
	linker tables
Date: Thu, 22 Dec 2016 16:08:22 +0200
Message-ID: <1482415702.9552.125.camel@linux.intel.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
 <20161222023811.21246-10-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20161222023811.21246-10-mcgrof@kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, linux@rasmusvillemoes.dk, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, sparclinux@vger.kernel.org, wangnan0@huawei.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, xen-devel@lists.xensource.com, msalter@redhat.com, linux-sh@vger.kernel.org, mpe@ellerman.id.au, joro@8bytes.org, x86@kernel.org, fontana@sharpeleven.org, dsahern@gmail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, linux@roeck-us.net, linux-xtensa@linux-xtensa.org, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb.de, jani.nikula@intel.com, will.deacon@arm.com, rusty@rustcorp.com.au, rostedt@goodmis.org, ak@
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCAyMDE2LTEyLTIxIGF0IDE4OjM4IC0wODAwLCBMdWlzIFIuIFJvZHJpZ3VleiB3cm90
ZToKPiBNb3ZlIHRoZSBfX2p1bXBfdGFibGUgZnJvbSB0aGUgYSBjdXN0b20gc2VjdGlvbiBzb2x1
dGlvbgo+IHRvIGEgZ2VuZXJpYyBzb2x1dGlvbiwgdGhpcyBhdm9pZGluZyBleHRyYSB2bWxpbnV4
Lmxkcy5oCj4gY3VzdG9taXphdGlvbnMuCj4gCj4gVGhpcyBhbHNvIGRlbW9zIHRoZSB1c2Ugb2Yg
dGhlIC5kYXRhIGxpbmtlciB0YWJsZSBhbmQgb2YKPiB0aGUgc2hhcmVkIGFzbSBjYWxsIHB1c2hf
c2VjdGlvbl90YmwoKS4KPiAKCj4gwqB7Cj4gwqAJYXNtX3ZvbGF0aWxlX2dvdG8oIjE6XG5cdCIK
PiDCoAkJwqBXQVNNKG5vcCkgIlxuXHQiCj4gLQkJwqAiLnB1c2hzZWN0aW9uIF9fanVtcF90YWJs
ZSzCoMKgXCJhd1wiXG5cdCIKPiArCQnCoHB1c2hfc2VjdGlvbl90YmxfYW55KC5kYXRhLCBfX2p1
bXBfdGFibGUsIGF3KQo+IMKgCQnCoCIud29yZCAxYiwgJWxbbF95ZXNdLCAlYzBcblx0Igo+IMKg
CQnCoCIucG9wc2VjdGlvblxuXHQiCj4gwqAJCcKgOiA6wqDCoCJpIiAoJigoY2hhciAqKWtleSlb
YnJhbmNoXSkgOsKgwqA6IGxfeWVzKTsKPiBAQCAtMjYsNyArMjgsNyBAQCBzdGF0aWMgX19hbHdh
eXNfaW5saW5lIGJvb2wKPiBhcmNoX3N0YXRpY19icmFuY2hfanVtcChzdHJ1Y3Qgc3RhdGljX2tl
eSAqa2V5LCBib29sCj4gwqB7Cj4gwqAJYXNtX3ZvbGF0aWxlX2dvdG8oIjE6XG5cdCIKPiDCoAkJ
wqBXQVNNKGIpICIgJWxbbF95ZXNdXG5cdCIKPiAtCQnCoCIucHVzaHNlY3Rpb24gX19qdW1wX3Rh
YmxlLMKgwqBcImF3XCJcblx0Igo+ICsJCcKgcHVzaF9zZWN0aW9uX3RibF9hbnkoLmRhdGEsIF9f
anVtcF90YWJsZSwgYXcpCj4gwqAJCcKgIi53b3JkIDFiLCAlbFtsX3llc10sICVjMFxuXHQiCj4g
wqAJCcKgIi5wb3BzZWN0aW9uXG5cdCIKCkRvZXMgaXQgbWFrZSBzZW5zZSB0byBpbnRyb2R1Y2Ug
c29tZXRoaW5nIGxpa2UKCiNkZWZpbmUgcG9wX3NlY3Rpb25fdGJsICIucG9wc2VjdGlvblxuXHQi
CiNkZWZpbmUgcG9wX3NlY3Rpb25fdGJsX2FueSBwb3Bfc2VjdGlvbl90YmwKCj8KCi0tIApBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KSW50ZWwgRmlu
bGFuZCBPeQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
WGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xp
c3RzLnhlbi5vcmcveGVuLWRldmVsCg==
