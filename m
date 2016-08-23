From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v1 7/7] tools: add userspace linker table
	sandbox
Date: Tue, 23 Aug 2016 02:07:39 +0200
Message-ID: <20160823000739.GX3296@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-8-git-send-email-mcgrof@kernel.org>
 <CAGXu5jKX-VZR_r9wMsnLAU+Z10vB4yDiRPpvwXbRZj0=wU208A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jKX-VZR_r9wMsnLAU+Z10vB4yDiRPpvwXbRZj0=wU208A@mail.gmail.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Kees Cook <keescook@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Ming Lei <ming.lei@canonical.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, platform-driver-x86@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux <sparclinux@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh <linux-sh@vger.kernel.org>, Will Deacon <will>
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMTYgYXQgMDM6MzE6NDdQTSAtMDcwMCwgS2VlcyBDb29rIHdyb3Rl
Ogo+IE9uIEZyaSwgQXVnIDE5LCAyMDE2IGF0IDI6NDEgUE0sICA8bWNncm9mQGtlcm5lbC5vcmc+
IHdyb3RlOgo+ID4gRnJvbTogIkx1aXMgUi4gUm9kcmlndWV6IiA8bWNncm9mQGtlcm5lbC5vcmc+
Cj4gPgo+ID4gQWRkIGEgdXNlcnNwYWNlIHNhbmRib3ggdG8gYWxsb3cgZWFzeSBleHBlcmltZW50
YXRpb24gYW5kCj4gPiB0ZXN0IGV4dGVuc2lvbnMgd2l0aCBsaW5rZXIgdGFibGVzLCBzZWN0aW9u
IHJhbmdlcyBhbmQgdGhlCj4gPiBuZXcgc2VjdGlvbiBjb3JlIGRlZmluaXRpb25zLgo+ID4KPiA+
IFRoZSB1c2Vyc3BhY2Ugc2FuZGJveCB0cmllcyB0byBtaW1pYyB0aGUgTGludXgga2VybmVsIGRl
dmVsb3BtZW50Cj4gPiBmbG93IGFzIG11Y2ggYXMgcG9zc2libGUsIGl0IGhvd2V2ZXIgcmVsaWVz
IG9uIGFuZCB1c2VzIGxpYmMuIFN1cHBvcnQKPiA+IGlzIGN1cnJlbnRseSBvbmx5IHByb3ZpZGVk
IHRvIHg4Nl82NC4KPiA+Cj4gPiB2NDogdGhpcyBwYXRjaCBpcyBuZXcgaW4gdGhpcyBzZXJpZXMg
LS0gYWRkZWQgdG8gdGhlIGtlbnJlbCBhcwo+ID4gICAgIHN1Z2dlc3RlZCBieSBCb3JpcywgYXMg
b3RoZXJ3aXNlIGl0J2QgYmUgcmVhbGx5IGhhcmQgdG8ga2VlcAo+ID4gICAgIGFuIGV4dGVybmFs
IHVzZXJzcGFjZSByZXBvc2l0b3J5IGluIHN5bmMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogTHVp
cyBSLiBSb2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwub3JnPgo+ID4gLS0tCj4gPiAgRG9jdW1lbnRh
dGlvbi9zZWN0aW9ucy9saW5rZXItdGFibGVzLnJzdCAgICAgICAgICAgfCAgIDQgKy0KPiA+ICBN
QUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
Cj4gPiAgaW5jbHVkZS9saW51eC90YWJsZXMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDUgKy0KPiA+ICB0b29scy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMyArLQo+ID4gIC4uLi9hcmNoL3g4Ni9pbmNsdWRlL2dlbmVyYXRlZC9hc20v
c2VjdGlvbi1jb3JlLmggIHwgICAxICsKPiA+ICB0b29scy9hcmNoL3g4Ni9pbmNsdWRlL2dlbmVy
YXRlZC9yYW5nZXMuaCAgICAgICAgICB8ICAgMSArCj4gPiAgdG9vbHMvYXJjaC94ODYvaW5jbHVk
ZS9nZW5lcmF0ZWQvdGFibGVzLmggICAgICAgICAgfCAgIDEgKwo+ID4gIHRvb2xzL2luY2x1ZGUv
YXNtLWdlbmVyaWMvcmFuZ2VzLmggICAgICAgICAgICAgICAgIHwgMTAzICsrKysKPiA+ICB0b29s
cy9pbmNsdWRlL2FzbS1nZW5lcmljL3NlY3Rpb24tY29yZS5oICAgICAgICAgICB8IDM0MSArKysr
KysrKysrKwo+ID4gIHRvb2xzL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGFibGVzLmggICAgICAgICAg
ICAgICAgIHwgIDUwICsrCj4gCj4gQXJlbid0IGEgYnVuY2ggb2YgdGhlc2UgZmlsZXMgZXhhY3Qg
ZHVwbGljYXRlcyBvZiB0aGUgaGVhZGVycyBpbiBpbmNsdWRlL2xpbnV4PwoKSW5kZWVkLi4uIFRo
aXMgYSB1c2Vyc3BhY2UgdG9vbHMvIGFyY2hpdGVjdHVyZSBkZWNpc2lvbiB0aGF0IHdhcyBtYWRl
IGxvbmcgYWdvLApzbyBpdHMgbm90IHVwIHRvIG1lLCBJIGFtIGp1c3QgZm9sbG93aW5nIHRoZSBz
dHJhdGVneSBkZXZpc2VkIGFuZCBwaWNrZWQgdXAuClJlZmVyIHRvIDdkN2QxYmYxZDFkYWJlNDM1
ZWY1MGVmYjA1MTcyNGI4NjY0NzQ5Y2IgKCJwZXJmIGJlbmNoOiBDb3B5IGtlcm5lbApmaWxlcyBu
ZWVkZWQgdG8gYnVpbGQgbWVte2NweSxzZXR9IHg4Nl82NCBiZW5jaG1hcmtzIikgZm9yIGFuIGV4
YW1wbGUgb2YKcHJldmlvdXMgc2ltaWxhciB3b3JrLiBCeSBzaGFyaW5nIGhlYWRlciBmaWxlcyB0
aGlzIGVuYWJsZSBtb3JlIHRvb2xzLwp0byBiZSBoYWNrZWQgb24uCgogIEx1aXMKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5n
IGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1k
ZXZlbAo=
