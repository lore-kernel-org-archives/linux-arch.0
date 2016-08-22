From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 04/16] generic-sections: add section core
	helpers
Date: Tue, 23 Aug 2016 01:13:03 +0200
Message-ID: <20160822231303.GT3296@wotan.suse.de>
References: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
 <1471642385-5629-5-git-send-email-mcgrof@kernel.org>
 <CAGXu5jL4u13rR76y49qF=0cZMQW97Bg4apPXNFMAkGyzD2-a7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jL4u13rR76y49qF=0cZMQW97Bg4apPXNFMAkGyzD2-a7Q@mail.gmail.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Kees Cook <keescook@chromium.org>
Cc: "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Ming Lei <ming.lei@canonical.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, platform-driver-x86@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux <sparclinux@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh <linux-sh@vger.kernel.org>, Will Deacon <will>
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMTYgYXQgMDI6NDc6NDhQTSAtMDcwMCwgS2VlcyBDb29rIHdyb3Rl
Ogo+IE9uIEZyaSwgQXVnIDE5LCAyMDE2IGF0IDI6MzIgUE0sICA8bWNncm9mQGtlcm5lbC5vcmc+
IHdyb3RlOgo+ID4gRnJvbTogIkx1aXMgUi4gUm9kcmlndWV6IiA8bWNncm9mQGtlcm5lbC5vcmc+
Cj4gPgo+ID4gK1NFQ1RJT05fUk9EQVRBCj4gPiArLS0tLS0tLS0tLS0tLS0KPiA+ICsuLiBrZXJu
ZWwtZG9jOjogaW5jbHVkZS9hc20tZ2VuZXJpYy9zZWN0aW9uLWNvcmUuaAo+ID4gKyAgIDpkb2M6
IFNFQ1RJT05fUk9EQVRBCj4gPiArCj4gPiArU0VDVElPTl9ST0RBVEEKPiAKPiBUeXBvOiBzaG91
bGQgdGhpcyBiZSBjYWxsZWQgU0VDVElPTl9URVhUIGluc3RlYWQ/CgpGaXhlZCB0aGFua3MuCgo+
ID4gKy0tLS0tLS0tLS0tLS0tCj4gPiArLi4ga2VybmVsLWRvYzo6IGluY2x1ZGUvYXNtLWdlbmVy
aWMvc2VjdGlvbi1jb3JlLmgKPiA+ICsgICA6ZG9jOiBTRUNUSU9OX1RFWFQKPiA+ICsKPiA+ICtT
RUNUSU9OX0RBVEEKPiA+ICstLS0tLS0tLS0tLS0KPiA+ICsuLiBrZXJuZWwtZG9jOjogaW5jbHVk
ZS9hc20tZ2VuZXJpYy9zZWN0aW9uLWNvcmUuaAo+ID4gKyAgIDpkb2M6IFNFQ1RJT05fREFUQQo+
IAo+IE1pc3NpbmcgZnJvbSB0aGlzIGxpc3QgYXJlIHRoaW5ncyBsaWtlIHRoZSBfX3JlYWRfbW9z
dGx5Cj4gKCIuZGF0YS4ucmVhZF9tb3N0bHkiKSBhbmQgX19yb19hZnRlcl9pbml0ICgiLmRhdGEu
LnJvX2FmdGVyX2luaXQiKQo+IHNlY3Rpb25zLiBTaG91bGQgdGhvc2UgYmUgaW5jbHVkZWQgdG9v
LCBvciBhcmUgeW91IG9ubHkgZG9pbmcgdGhlICJ0b3AKPiBsZXZlbCIgc2VjdGlvbnM/CgpJJ20g
ZG9pbmcgdG9wIGxldmVsIHJpZ2h0IG5vdyBqdXN0IHRvIHN0YXJ0IG9mZiBhbmQgZ2V0IHRoZQpi
aWtlc2hlZGRpbmcgb3V0IG9mIHRoZSB3YXkuIFdlIGNhbiBhZGQgbW9yZSB3aXRoIG1vcmUgdGlt
ZQpvciBhcyB3ZSBwb3J0IG1vcmUgdGhpbmdzIG9yIGFzIHRoZSBuZWVkIGFyaXNlcy4KCiAgTHVp
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRl
dmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhl
bi5vcmcveGVuLWRldmVsCg==
