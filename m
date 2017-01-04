From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 04/14] tables.h: add linker table support
Date: Wed, 4 Jan 2017 11:47:14 +0200
Message-ID: <CAHp75Vd-WoYd40m0piYHUNdhJnYV9aHyQaMAJpN1YLx0nSAe5g@mail.gmail.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
 <20161222023811.21246-5-mcgrof@kernel.org>
 <1482415098.9552.123.camel@linux.intel.com>
 <20170103212528.GE13946@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20170103212528.GE13946@wotan.suse.de>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dalias@libc.org, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, ming.lei@canonical.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, masami.hiramatsu.pt@hitachi.com, wangnan0@huawei.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux-Arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Linux-SH <linux-sh@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, korea.drzix@gmail.com, x86@k
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCBKYW4gMywgMjAxNyBhdCAxMToyNSBQTSwgTHVpcyBSLiBSb2RyaWd1ZXogPG1jZ3Jv
ZkBrZXJuZWwub3JnPiB3cm90ZToKPiBPbiBUaHUsIERlYyAyMiwgMjAxNiBhdCAwMzo1ODoxOFBN
ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4+IE9uIFdlZCwgMjAxNi0xMi0yMSBhdCAx
ODozOCAtMDgwMCwgTHVpcyBSLiBSb2RyaWd1ZXogd3JvdGU6Cj4+ID4gKyNkZWZpbmUgTElOS1RB
QkxFX0ZPUl9FQUNIKHBvaW50ZXIsIHRibCkKPj4KPj4gSG1tLi4uIFNPTUVPTkUgTElLRVMgQ0FQ
SVRBTCBMRVRURVJTIEZPUiBldmVyeXRoaW5nLCByaWdodD8gOi0pCj4+Cj4+IEkgd291bGQgZXhw
ZWN0IG1vcmUgc3RhbmRhcmQgbGlua3RhYmxlX2Zvcl9lYWNoKCkgbWFjcm8KPgo+IGhwYSBoYWQg
cmVjb21tZW5kZWQgdGhpcywgaWYgaGUgcHJlZmVycyBhIGxvd2VyIGNhc2UgSSBjYW4gY2hhbmdl
IHRoYXQKCgo+IGJ1dCBJIHJlYWxseSBkbyBjb25zaWRlciB0aGlzIGJpa2VzaGVkZGluZy4KCkkg
ZG9uJ3QgdGhpbmsgc286CiQgZ2l0IGdyZXAgLW4gRk9SX0VBQ0ggfCB3YyAtbAogICAgODMKJCBn
aXQgZ3JlcCAtbiBmb3JfZWFjaCB8IHdjIC1sCiAyMzMxNwoKLS0gCldpdGggQmVzdCBSZWdhcmRz
LApBbmR5IFNoZXZjaGVua28KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcK
aHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1kZXZlbAo=
