From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 04/14] tables.h: add linker table support
Date: Fri, 6 Jan 2017 21:00:21 +0100
Message-ID: <20170106200021.GU13946@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
 <20161222023811.21246-5-mcgrof@kernel.org>
 <1482415098.9552.123.camel@linux.intel.com>
 <20170103212528.GE13946@wotan.suse.de>
 <CAHp75Vd-WoYd40m0piYHUNdhJnYV9aHyQaMAJpN1YLx0nSAe5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vd-WoYd40m0piYHUNdhJnYV9aHyQaMAJpN1YLx0nSAe5g@mail.gmail.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dalias@libc.org, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, ming.lei@canonical.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, masami.hiramatsu.pt@hitachi.com, wangnan0@huawei.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux-Arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Linux-SH <linux-sh@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, korea.drzix@gmail.com, x86@k
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCBKYW4gMDQsIDIwMTcgYXQgMTE6NDc6MTRBTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOgo+IE9uIFR1ZSwgSmFuIDMsIDIwMTcgYXQgMTE6MjUgUE0sIEx1aXMgUi4gUm9kcmln
dWV6IDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiBPbiBUaHUsIERlYyAyMiwgMjAxNiBh
dCAwMzo1ODoxOFBNICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gPj4gT24gV2VkLCAy
MDE2LTEyLTIxIGF0IDE4OjM4IC0wODAwLCBMdWlzIFIuIFJvZHJpZ3VleiB3cm90ZToKPiA+PiA+
ICsjZGVmaW5lIExJTktUQUJMRV9GT1JfRUFDSChwb2ludGVyLCB0YmwpCj4gPj4KPiA+PiBIbW0u
Li4gU09NRU9ORSBMSUtFUyBDQVBJVEFMIExFVFRFUlMgRk9SIGV2ZXJ5dGhpbmcsIHJpZ2h0PyA6
LSkKPiA+Pgo+ID4+IEkgd291bGQgZXhwZWN0IG1vcmUgc3RhbmRhcmQgbGlua3RhYmxlX2Zvcl9l
YWNoKCkgbWFjcm8KPiA+Cj4gPiBocGEgaGFkIHJlY29tbWVuZGVkIHRoaXMsIGlmIGhlIHByZWZl
cnMgYSBsb3dlciBjYXNlIEkgY2FuIGNoYW5nZSB0aGF0Cj4gCj4gCj4gPiBidXQgSSByZWFsbHkg
ZG8gY29uc2lkZXIgdGhpcyBiaWtlc2hlZGRpbmcuCj4gCj4gSSBkb24ndCB0aGluayBzbzoKPiAk
IGdpdCBncmVwIC1uIEZPUl9FQUNIIHwgd2MgLWwKPiAgICAgODMKPiAkIGdpdCBncmVwIC1uIGZv
cl9lYWNoIHwgd2MgLWwKPiAgMjMzMTcKCk9LLCB3b3VsZCB5b3UgYWxzbyBwcmVmZXIgaWYgTElO
S1RBQkxFX1JVTl9FUlIoKSBhbmQgTElOS1RBQkxFX1JVTl9BTEwoKQp3ZXJlIGxvd2VyY2FzZSA/
IE9yIGlzIHRoYXQgZmluZSA/IFRvIGJlIGNsZWFyIEknbGwgbGVhdmUgdXBwZXIgY2FzZSB0aGUK
ZGVjbGFyZXJzIGFuZCBkZWZpbmVzLgoKICBMdWlzCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBs
aXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
