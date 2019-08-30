From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Revert "asm-generic: Remove unneeded
 __ARCH_WANT_SYS_LLSEEK macro"
Date: Fri, 30 Aug 2019 22:37:44 +0200
Message-ID: <CAK8P3a1nGnB3GWEAso9MKW5HuxuB9ez46HZgS=GX-odtJuAMWQ@mail.gmail.com>
References: <bb6d25c6baae315d05b571d8c508f0e8fa90027c.1567188299.git.msuchanek@suse.de>
 <20190830194651.31043-1-msuchanek@suse.de>
 <CAK8P3a16=ktJm5B3c5-XS7SqVuHBY5+E2FwVUqbdOdWK-AUgSA@mail.gmail.com>
 <20190830221315.4b3b8a74@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190830221315.4b3b8a74@kitsune.suse.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>Linu
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBBdWcgMzAsIDIwMTkgYXQgMTA6MTMgUE0gTWljaGFsIFN1Y2jDoW5layA8bXN1Y2hh
bmVrQHN1c2UuZGU+IHdyb3RlOgo+IE9uIEZyaSwgMzAgQXVnIDIwMTkgMjE6NTQ6NDMgKzAyMDAK
PiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiB3cm90ZToKPiA+ID4gaW5kZXggNWJiZjU4
N2Y1YmMxLi4yZjNjNGJiMTM4YzQgMTAwNjQ0Cj4gPiA+IC0tLSBhL2ZzL3JlYWRfd3JpdGUuYwo+
ID4gPiArKysgYi9mcy9yZWFkX3dyaXRlLmMKPiA+ID4gQEAgLTMzMSw3ICszMzEsNyBAQCBDT01Q
QVRfU1lTQ0FMTF9ERUZJTkUzKGxzZWVrLCB1bnNpZ25lZCBpbnQsIGZkLCBjb21wYXRfb2ZmX3Qs
IG9mZnNldCwgdW5zaWduZWQgaQo+ID4gPiAgfQo+ID4gPiAgI2VuZGlmCj4gPiA+Cj4gPiA+IC0j
aWYgIWRlZmluZWQoQ09ORklHXzY0QklUKSB8fCBkZWZpbmVkKENPTkZJR19DT01QQVQpCj4gPiA+
ICsjaWZkZWYgX19BUkNIX1dBTlRfU1lTX0xMU0VFSwo+ID4gPiAgU1lTQ0FMTF9ERUZJTkU1KGxs
c2VlaywgdW5zaWduZWQgaW50LCBmZCwgdW5zaWduZWQgbG9uZywgb2Zmc2V0X2hpZ2gsCj4gPiA+
ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nLCBvZmZzZXRfbG93LCBsb2ZmX3QgX191c2Vy
ICosIHJlc3VsdCwKPiA+ID4gICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCwgd2hlbmNlKQo+
ID4KPiA+IEhvd2V2ZXIsIG9ubHkgcmV2ZXJ0aW5nIHRoZSBwYXRjaCB3aWxsIG5vdyBicmVhayBh
bGwgbmV3bHkgYWRkZWQKPiA+IDMyLWJpdCBhcmNoaXRlY3R1cmVzIHRoYXQgZG9uJ3QgZGVmaW5l
IF9fQVJDSF9XQU5UX1NZU19MTFNFRUs6Cj4gPiBhdCBsZWFzdCBuZHMzMiBhbmQgcmlzY3YzMiBj
b21lIHRvIG1pbmQsIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGFub3RoZXIuCj4KPiBBRkFJQ1QgbmRz
MzIgbmV2ZXIgaGFkIHRoZSBzeXNjYWxsLiBJdHMgaGVhZGVycyB3ZXJlIGFkZGVkIHdpdGhvdXQK
PiBfX0FSQ0hfV0FOVF9TWVNfTExTRUVLIGJlZm9yZSB0aGUgZGVmaW5lIHdhcyByZW1vdmVkLgoK
bmRzMzIgZ290IGl0IGZyb20gaW5jbHVkZS9hc20tZ2VuZXJpYy91bmlzdGQuaAoKICAgICAgICBB
cm5kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
