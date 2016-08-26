From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 04/16] generic-sections: add section core
	helpers
Date: Fri, 26 Aug 2016 15:22:19 +0200
Message-ID: <20160826132219.GG3296@wotan.suse.de>
References: <20160823173306.GA3296@wotan.suse.de>
 <20160824135141.2c8f06ec@roar.ozlabs.ibm.com>
 <20160824201253.GS3296@wotan.suse.de>
 <20160825120633.057b2f6f@roar.ozlabs.ibm.com>
 <20160825060540.GX3296@wotan.suse.de>
 <20160825165121.45d26fb0@roar.ozlabs.ibm.com>
 <20160825175239.GB3296@wotan.suse.de>
 <20160826130024.0ad51d33@roar.ozlabs.ibm.com>
 <CAB=NE6UQ8qE6AqRg9=YddNYrMyU7opCEij-5Usty7wMgEJJbpw@mail.gmail.com>
 <20160826173338.41a56103@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20160826173338.41a56103@roar.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, realmz6@gmail.com, linux-sh@vger.kernel.org, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, linux@rasmusvillemoes.dk, platform-driver-x86@vger.kernel.org, James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com, paulus@samba.org, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, msalter@redhat.com, davem@davemloft.net, mpe@ellerman.id.au, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, mhiramat@kernel.org, linux-xtensa@linux-xtensa.org, rusty@rustcorp.com.au, keescook@chromium.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, jani.nikula@int
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMTYgYXQgMDU6MzM6MzhQTSArMTAwMCwgTmljaG9sYXMgUGlnZ2lu
IHdyb3RlOgo+IE9uIFRodSwgMjUgQXVnIDIwMTYgMjM6Mzg6NDQgLTA3MDAKPiAiTHVpcyBSLiBS
b2RyaWd1ZXoiIDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiA+ID4gPiA+IEFoLCB0aGlu
ZyBpcyB3ZSB1c2UgdGhpcyBmb3IgYm90aCBsaW5rdGFibGVzIGFuZCBzZWN0aW9uIHJhbmdlcy4K
PiA+ID4gPiA+ID4gT3IgZG8gd2Ugd2FudCBtYWNyb3MgZm9yIGJvdGggdGhhdCBkbyB0aGUgc2Ft
ZSB0aGluZyA/ICAKPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIHRoaW5rIGl0IHdvdWxkIG1ha2UgdGhl
IGNvZGUgdXNpbmcgaXQgbW9yZSByZWFkYWJsZS4gIAo+ID4gPiA+Cj4gPiA+ID4gQWxyaWdodHku
Li4gc286Cj4gPiA+ID4KPiA+ID4gPiBMSU5LVEFCTEVfU1RBUlQoKQo+ID4gPiA+IExJTktUQUJM
RV9FTkQoKQo+ID4gPiA+Cj4gPiA+ID4gU0VDVElPTl9SQU5HRV9TVEFSVCgpCj4gPiA+ID4gU0VD
VElPTl9SQU5HRV9FTkQoKQo+ID4gPiA+Cj4gPiA+ID4gQW5kIHRoZXNlIG1hY3JvcyBkbyB0aGUg
ZXhhY3Qgc2FtZSB0aGluZy4gSWUsIG5vdGhpbmcgc2hhcmVkLiBSaWdodD8gIAo+ID4gPgo+ID4g
PiBZZWFoIEkgdGhpbmsgc28uIEludGVybmFsbHkgdGhleSB3b3VsZCBwcm9iYWJseSBiZSBhbGlh
c2VkIHRvIHRoZQo+ID4gPiBzYW1lIGNvbW1vbiBkZWZpbml0aW9uICh1bmxlc3MgeW91IGhhZCBz
b21lIHR5cGUgY2hlY2sgb3Igc29tZXRoaW5nKSwKPiA+ID4gYnV0IHVzZXIgd291bGQga25vdyBh
Ym91dCBzdWNoIGRldGFpbHMuICAKPiA+IAo+ID4gV2hhdCBuYW1lIHNob3VsZCB3ZSB1c2UgZm9y
IHN1Y2ggY29tbW9uIG1hY3JvIGRlZmluaXRpb24gPwo+IAo+IAo+IEFoLCBub3QgcmVhbGx5IHN1
cmUuIEkgZ3Vlc3MgdGhlICJsaW5rIHRhYmxlIiBpcyBzb21lIGtpbmQgb2YKPiBzZWN0aW9uIHJh
bmdlPyBJIGhhdmVuJ3QgYWN0dWFsbHkgbG9va2VkIGNsb3NlbHkgYXQgYm90aCBvZiB0aGVtCj4g
aW4gdGhlIHN1YnNlcXVlbnQgcGF0Y2hlcy4gSXQgbWF0dGVycyBsZXNzIGlmIGl0J3Mgbm90IGV4
cGVjdGVkCj4gdG8gYmUgdXNlZCBhcyBhbiBBUEkgdGhvdWdoLgo+IAoKT0sgd2VsbCwgZ29pbmcg
d2l0aCBMSU5VWF9TRUNUSU9OX1NUQVJUKCkgc28gd2UnbGwgaGF2ZToKCiNkZWZpbmUgTElOS1RB
QkxFX1NUQVJUCQlMSU5VWF9TRUNUSU9OX1NUQVJUCiNkZWZpbmUgTElOS1RBQkxFX0VORAkJTElO
VVhfU0VDVElPTl9FTkQKCiNkZWZpbmUgU0VDVElPTl9SQU5HRV9TVEFSVAlMSU5VWF9TRUNUSU9O
X1NUQVJUCiNkZWZpbmUgU0VDVElPTl9SQU5HRV9FTkQJTElOVVhfU0VDVElPTl9FTkQKCklzIHRo
YXQgT0s/CgogIEx1aXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0
cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1kZXZlbAo=
