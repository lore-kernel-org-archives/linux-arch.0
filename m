From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 04/14] tables.h: add linker table support
Date: Fri, 6 Jan 2017 22:43:59 +0200
Message-ID: <CAHp75Vc1V74hhcy0nzUuDoHDtzyTAHpBN2fddiCqzGJTRL_rOg@mail.gmail.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
 <20161222023811.21246-5-mcgrof@kernel.org>
 <1482415098.9552.123.camel@linux.intel.com>
 <20170103212528.GE13946@wotan.suse.de>
 <CAHp75Vd-WoYd40m0piYHUNdhJnYV9aHyQaMAJpN1YLx0nSAe5g@mail.gmail.com>
 <20170106200021.GU13946@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20170106200021.GU13946@wotan.suse.de>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dalias@libc.org, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, ming.lei@canonical.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, wangnan0@huawei.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux-Arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Linux-SH <linux-sh@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, korea.drzix@gmail.com, "x86@kernel.org" <x86@kernel.org>, anil
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBKYW4gNiwgMjAxNyBhdCAxMDowMCBQTSwgTHVpcyBSLiBSb2RyaWd1ZXogPG1jZ3Jv
ZkBrZXJuZWwub3JnPiB3cm90ZToKPiBPbiBXZWQsIEphbiAwNCwgMjAxNyBhdCAxMTo0NzoxNEFN
ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4+IE9uIFR1ZSwgSmFuIDMsIDIwMTcgYXQg
MTE6MjUgUE0sIEx1aXMgUi4gUm9kcmlndWV6IDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6Cj4+
ID4gT24gVGh1LCBEZWMgMjIsIDIwMTYgYXQgMDM6NTg6MThQTSArMDIwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOgo+PiA+PiBPbiBXZWQsIDIwMTYtMTItMjEgYXQgMTg6MzggLTA4MDAsIEx1aXMg
Ui4gUm9kcmlndWV6IHdyb3RlOgo+PiA+PiA+ICsjZGVmaW5lIExJTktUQUJMRV9GT1JfRUFDSChw
b2ludGVyLCB0YmwpCj4+ID4+Cj4+ID4+IEhtbS4uLiBTT01FT05FIExJS0VTIENBUElUQUwgTEVU
VEVSUyBGT1IgZXZlcnl0aGluZywgcmlnaHQ/IDotKQo+PiA+Pgo+PiA+PiBJIHdvdWxkIGV4cGVj
dCBtb3JlIHN0YW5kYXJkIGxpbmt0YWJsZV9mb3JfZWFjaCgpIG1hY3JvCj4+ID4KPj4gPiBocGEg
aGFkIHJlY29tbWVuZGVkIHRoaXMsIGlmIGhlIHByZWZlcnMgYSBsb3dlciBjYXNlIEkgY2FuIGNo
YW5nZSB0aGF0Cj4+Cj4+Cj4+ID4gYnV0IEkgcmVhbGx5IGRvIGNvbnNpZGVyIHRoaXMgYmlrZXNo
ZWRkaW5nLgo+Pgo+PiBJIGRvbid0IHRoaW5rIHNvOgo+PiAkIGdpdCBncmVwIC1uIEZPUl9FQUNI
IHwgd2MgLWwKPj4gICAgIDgzCj4+ICQgZ2l0IGdyZXAgLW4gZm9yX2VhY2ggfCB3YyAtbAo+PiAg
MjMzMTcKPgo+IE9LLCB3b3VsZCB5b3UgYWxzbyBwcmVmZXIgaWYgTElOS1RBQkxFX1JVTl9FUlIo
KSBhbmQgTElOS1RBQkxFX1JVTl9BTEwoKQo+IHdlcmUgbG93ZXJjYXNlID8gT3IgaXMgdGhhdCBm
aW5lID8gVG8gYmUgY2xlYXIgSSdsbCBsZWF2ZSB1cHBlciBjYXNlIHRoZQo+IGRlY2xhcmVycyBh
bmQgZGVmaW5lcy4KCk15IHVuZGVyc3RhbmRpbmcgdGhhdCBtYWNyb3MgdG8gcnVuIGNvZGUgLS0g
bG93ZXIgY2FzZSwgZGVmaW5pdGlvbnMgLS0KdXBwZXIgY2FzZS4KClRodXMsICpfcnVuXyooKSBt
YWNyb3MgdG8gbG93ZXIuCgotLSAKV2l0aCBCZXN0IFJlZ2FyZHMsCkFuZHkgU2hldmNoZW5rbwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVs
IG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5v
cmcveGVuLWRldmVsCg==
