From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 04/14] tables.h: add linker table support
Date: Mon, 9 Jan 2017 15:22:08 +0100
Message-ID: <20170109142208.GY13946@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
 <20161222023811.21246-5-mcgrof@kernel.org>
 <1482415098.9552.123.camel@linux.intel.com>
 <20170103212528.GE13946@wotan.suse.de>
 <CAHp75Vd-WoYd40m0piYHUNdhJnYV9aHyQaMAJpN1YLx0nSAe5g@mail.gmail.com>
 <20170106200021.GU13946@wotan.suse.de>
 <CAHp75Vc1V74hhcy0nzUuDoHDtzyTAHpBN2fddiCqzGJTRL_rOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vc1V74hhcy0nzUuDoHDtzyTAHpBN2fddiCqzGJTRL_rOg@mail.gmail.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dalias@libc.org, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, ming.lei@canonical.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, wangnan0@huawei.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux-Arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Linux-SH <linux-sh@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, korea.drzix@gmail.com, "x86@kernel.org" <x86@kernel.org>, anil
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBKYW4gMDYsIDIwMTcgYXQgMTA6NDM6NTlQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOgo+IE9uIEZyaSwgSmFuIDYsIDIwMTcgYXQgMTA6MDAgUE0sIEx1aXMgUi4gUm9kcmln
dWV6IDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiBPbiBXZWQsIEphbiAwNCwgMjAxNyBh
dCAxMTo0NzoxNEFNICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gPj4gT24gVHVlLCBK
YW4gMywgMjAxNyBhdCAxMToyNSBQTSwgTHVpcyBSLiBSb2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwu
b3JnPiB3cm90ZToKPiA+PiA+IE9uIFRodSwgRGVjIDIyLCAyMDE2IGF0IDAzOjU4OjE4UE0gKzAy
MDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPiA+PiA+PiBPbiBXZWQsIDIwMTYtMTItMjEgYXQg
MTg6MzggLTA4MDAsIEx1aXMgUi4gUm9kcmlndWV6IHdyb3RlOgo+ID4+ID4+ID4gKyNkZWZpbmUg
TElOS1RBQkxFX0ZPUl9FQUNIKHBvaW50ZXIsIHRibCkKPiA+PiA+Pgo+ID4+ID4+IEhtbS4uLiBT
T01FT05FIExJS0VTIENBUElUQUwgTEVUVEVSUyBGT1IgZXZlcnl0aGluZywgcmlnaHQ/IDotKQo+
ID4+ID4+Cj4gPj4gPj4gSSB3b3VsZCBleHBlY3QgbW9yZSBzdGFuZGFyZCBsaW5rdGFibGVfZm9y
X2VhY2goKSBtYWNybwo+ID4+ID4KPiA+PiA+IGhwYSBoYWQgcmVjb21tZW5kZWQgdGhpcywgaWYg
aGUgcHJlZmVycyBhIGxvd2VyIGNhc2UgSSBjYW4gY2hhbmdlIHRoYXQKPiA+Pgo+ID4+Cj4gPj4g
PiBidXQgSSByZWFsbHkgZG8gY29uc2lkZXIgdGhpcyBiaWtlc2hlZGRpbmcuCj4gPj4KPiA+PiBJ
IGRvbid0IHRoaW5rIHNvOgo+ID4+ICQgZ2l0IGdyZXAgLW4gRk9SX0VBQ0ggfCB3YyAtbAo+ID4+
ICAgICA4Mwo+ID4+ICQgZ2l0IGdyZXAgLW4gZm9yX2VhY2ggfCB3YyAtbAo+ID4+ICAyMzMxNwo+
ID4KPiA+IE9LLCB3b3VsZCB5b3UgYWxzbyBwcmVmZXIgaWYgTElOS1RBQkxFX1JVTl9FUlIoKSBh
bmQgTElOS1RBQkxFX1JVTl9BTEwoKQo+ID4gd2VyZSBsb3dlcmNhc2UgPyBPciBpcyB0aGF0IGZp
bmUgPyBUbyBiZSBjbGVhciBJJ2xsIGxlYXZlIHVwcGVyIGNhc2UgdGhlCj4gPiBkZWNsYXJlcnMg
YW5kIGRlZmluZXMuCj4gCj4gTXkgdW5kZXJzdGFuZGluZyB0aGF0IG1hY3JvcyB0byBydW4gY29k
ZSAtLSBsb3dlciBjYXNlLCBkZWZpbml0aW9ucyAtLQo+IHVwcGVyIGNhc2UuCj4gCj4gVGh1cywg
Kl9ydW5fKigpIG1hY3JvcyB0byBsb3dlci4KClZlcnkgd2VsbCwgSSd2ZSBjaGFuZ2VkIHRoZXNl
LCBhbmQgc2luY2UgdGhlcmUgd2VyZSB1c2VycyBJIGhhZCB0byBjaGFuZ2UKYSBiaXQgb2YgdGhl
IG90aGVyIHBhdGNoZXMgc28gd2lsbCBzZW5kIGEgdjYgc2VyaWVzIGZvbGxvdyB1cC4KCiAgTHVp
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRl
dmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhl
bi5vcmcveGVuLWRldmVsCg==
