From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 7/7] tools: add userspace linker table
	sandbox
Date: Fri, 19 Aug 2016 15:31:47 -0700
Message-ID: <CAGXu5jKX-VZR_r9wMsnLAU+Z10vB4yDiRPpvwXbRZj0=wU208A@mail.gmail.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-8-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1471642875-5957-8-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Ming Lei <ming.lei@canonical.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, platform-driver-x86@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux <sparclinux@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh <linux-sh@vger.kernel.org>, Will Deacon <will>
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMTYgYXQgMjo0MSBQTSwgIDxtY2dyb2ZAa2VybmVsLm9yZz4gd3Jv
dGU6Cj4gRnJvbTogIkx1aXMgUi4gUm9kcmlndWV6IiA8bWNncm9mQGtlcm5lbC5vcmc+Cj4KPiBB
ZGQgYSB1c2Vyc3BhY2Ugc2FuZGJveCB0byBhbGxvdyBlYXN5IGV4cGVyaW1lbnRhdGlvbiBhbmQK
PiB0ZXN0IGV4dGVuc2lvbnMgd2l0aCBsaW5rZXIgdGFibGVzLCBzZWN0aW9uIHJhbmdlcyBhbmQg
dGhlCj4gbmV3IHNlY3Rpb24gY29yZSBkZWZpbml0aW9ucy4KPgo+IFRoZSB1c2Vyc3BhY2Ugc2Fu
ZGJveCB0cmllcyB0byBtaW1pYyB0aGUgTGludXgga2VybmVsIGRldmVsb3BtZW50Cj4gZmxvdyBh
cyBtdWNoIGFzIHBvc3NpYmxlLCBpdCBob3dldmVyIHJlbGllcyBvbiBhbmQgdXNlcyBsaWJjLiBT
dXBwb3J0Cj4gaXMgY3VycmVudGx5IG9ubHkgcHJvdmlkZWQgdG8geDg2XzY0Lgo+Cj4gdjQ6IHRo
aXMgcGF0Y2ggaXMgbmV3IGluIHRoaXMgc2VyaWVzIC0tIGFkZGVkIHRvIHRoZSBrZW5yZWwgYXMK
PiAgICAgc3VnZ2VzdGVkIGJ5IEJvcmlzLCBhcyBvdGhlcndpc2UgaXQnZCBiZSByZWFsbHkgaGFy
ZCB0byBrZWVwCj4gICAgIGFuIGV4dGVybmFsIHVzZXJzcGFjZSByZXBvc2l0b3J5IGluIHN5bmMu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBMdWlzIFIuIFJvZHJpZ3VleiA8bWNncm9mQGtlcm5lbC5vcmc+
Cj4gLS0tCj4gIERvY3VtZW50YXRpb24vc2VjdGlvbnMvbGlua2VyLXRhYmxlcy5yc3QgICAgICAg
ICAgIHwgICA0ICstCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxICsKPiAgaW5jbHVkZS9saW51eC90YWJsZXMuaCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDUgKy0KPiAgdG9vbHMvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKy0KPiAgLi4uL2FyY2gveDg2L2luY2x1ZGUvZ2Vu
ZXJhdGVkL2FzbS9zZWN0aW9uLWNvcmUuaCAgfCAgIDEgKwo+ICB0b29scy9hcmNoL3g4Ni9pbmNs
dWRlL2dlbmVyYXRlZC9yYW5nZXMuaCAgICAgICAgICB8ICAgMSArCj4gIHRvb2xzL2FyY2gveDg2
L2luY2x1ZGUvZ2VuZXJhdGVkL3RhYmxlcy5oICAgICAgICAgIHwgICAxICsKPiAgdG9vbHMvaW5j
bHVkZS9hc20tZ2VuZXJpYy9yYW5nZXMuaCAgICAgICAgICAgICAgICAgfCAxMDMgKysrKwo+ICB0
b29scy9pbmNsdWRlL2FzbS1nZW5lcmljL3NlY3Rpb24tY29yZS5oICAgICAgICAgICB8IDM0MSAr
KysrKysrKysrKwo+ICB0b29scy9pbmNsdWRlL2FzbS1nZW5lcmljL3RhYmxlcy5oICAgICAgICAg
ICAgICAgICB8ICA1MCArKwoKQXJlbid0IGEgYnVuY2ggb2YgdGhlc2UgZmlsZXMgZXhhY3QgZHVw
bGljYXRlcyBvZiB0aGUgaGVhZGVycyBpbiBpbmNsdWRlL2xpbnV4PwoKLUtlZXMKCi0tIApLZWVz
IENvb2sKTmV4dXMgU2VjdXJpdHkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5v
cmcKaHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1kZXZlbAo=
