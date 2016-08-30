From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 08/16] kbuild: enable option to force
 compile force-obj-y and force-lib-y
Date: Tue, 30 Aug 2016 22:15:57 +0200
Message-ID: <20160830201557.GY3296@wotan.suse.de>
References: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
 <1471642385-5629-9-git-send-email-mcgrof@kernel.org>
 <CAGXu5jKhopn4swNvNJ4EKXh0-gKrKFfbR-9n_W6bFdgujgBr+w@mail.gmail.com>
 <20160822235910.GW3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20160822235910.GW3296@wotan.suse.de>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Michal Marek <mmarek@suse.com>
Cc: "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Ming Lei <ming.lei@canonical.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, platform-driver-x86@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux <sparclinux@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh <linux-sh@vger.kernel.org>, Will Deacon <will>
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCBBdWcgMjMsIDIwMTYgYXQgMDE6NTk6MTBBTSArMDIwMCwgTHVpcyBSLiBSb2RyaWd1
ZXogd3JvdGU6Cj4gT24gRnJpLCBBdWcgMTksIDIwMTYgYXQgMDM6MTA6MzNQTSAtMDcwMCwgS2Vl
cyBDb29rIHdyb3RlOgo+ID4gT24gRnJpLCBBdWcgMTksIDIwMTYgYXQgMjozMiBQTSwgIDxtY2dy
b2ZAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiA+IGRpZmYgLS1naXQgYS9pbml0L0tjb25maWcgYi9p
bml0L0tjb25maWcKPiA+ID4gaW5kZXggY2FjM2YwOTYwNTBkLi5lZjA5ZTgzYjkxOTYgMTAwNjQ0
Cj4gPiA+IC0tLSBhL2luaXQvS2NvbmZpZwo+ID4gPiArKysgYi9pbml0L0tjb25maWcKPiA+ID4g
QEAgLTUzLDYgKzUzLDI4IEBAIGNvbmZpZyBDUk9TU19DT01QSUxFCj4gPiA+ICAgICAgICAgICBu
ZWVkIHRvIHNldCB0aGlzIHVubGVzcyB5b3Ugd2FudCB0aGUgY29uZmlndXJlZCBrZXJuZWwgYnVp
bGQKPiA+ID4gICAgICAgICAgIGRpcmVjdG9yeSB0byBzZWxlY3QgdGhlIGNyb3NzLWNvbXBpbGVy
IGF1dG9tYXRpY2FsbHkuCj4gPiA+Cj4gPiA+ICtjb25maWcgQlVJTERfQVZPSURfQklUUk9UCj4g
PiA+ICsgICAgICAgYm9vbCAiRW5hYmxlIGZvcmNlIGJ1aWxkaW5nIG9mIGZvcmNlLW9iai15IGFu
ZCBmb3JjZS1saWIteSIKPiA+IAo+ID4gU29ycnkgdG8gY29udGludWUgdGhlIGJpa2VzaGVkZGlu
ZyBvbiB0aGlzLCBidXQgaWYgSSBlbmNvdW50ZXIKPiA+IHNvbWV0aGluZyBpbiBhIE1ha2VmaWxl
IG5hbWVkICJmb3JjZS1vYmoteSIgSSB3b3VsZCBleHBlY3QgaXQgdG8KPiA+IGFsd2F5cyBiZSBi
dWlsdCwgbm8gbWF0dGVyIHdoYXQuIEJ1dCB0aGlzIGlzIG5vdCB0aGUgY2FzZTogdGhlCj4gPiAi
Zm9yY2UtIiBwcmVmaXggaXMgdGllZCB0byB0aGlzIENPTkZJR19CVUlMRF9BVk9JRF9CSVRST1Qu
IFRoaXMgdmVyYgo+ID4gdXNhZ2UgaXMgd2VpcmQsIGFzIEknZCBleHBlY3QgYW4gYWRqZWN0aXZl
LCBsaWtlICJmb3JjZWFibGUtb2JqLXkiIG9yCj4gPiBzb21ldGhpbmcgdGhhdCBkZXNjcmliZXMg
dGhhdCBpdCBDQU4gYmUgYnVpbHQgZXZlbiB3aXRoIHRoZSBDT05GSUcgZm9yCj4gPiBpdCBpcyBt
aXNzaW5nLCBldGMuCj4gPiAKPiA+IFJlZ2FyZGxlc3MsIEkgZGVmZXIgdG8gTWljaGFsIG9uIHRo
aXMsIGJ1dCBJJ20gbm90IGEgZmFuIG9mICJmb3JjZSIKPiA+IGJlaW5nIHVzZWQgd2hlbiBpdCdz
IGFuIG9wdGlvbmFsIGFjdGlvbi4gOikKPiAKPiBTdXJlLCBNaWNoYWwgbGV0IG1lIGtub3cgaWYg
Zm9yY2VhYmxlLW9iai15IGFuZCBmb3JjZWFibGUtbGliLXkgaXMgdGhlCj4gd2F5IHRvIGdvLgoK
TWljaGFsPyBBbnkgcHJlZmVyZW5jZSA/IE9yIGhvdyBhYm91dCBvcHQtZm9yY2Utb2JqID8KCiAg
THVpcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVu
LWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3Rz
Lnhlbi5vcmcveGVuLWRldmVsCg==
