From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 08/16] kbuild: enable option to force
 compile force-obj-y and force-lib-y
Date: Tue, 23 Aug 2016 01:59:10 +0200
Message-ID: <20160822235910.GW3296@wotan.suse.de>
References: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
 <1471642385-5629-9-git-send-email-mcgrof@kernel.org>
 <CAGXu5jKhopn4swNvNJ4EKXh0-gKrKFfbR-9n_W6bFdgujgBr+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jKhopn4swNvNJ4EKXh0-gKrKFfbR-9n_W6bFdgujgBr+w@mail.gmail.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>
Cc: "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Ming Lei <ming.lei@canonical.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, platform-driver-x86@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux <sparclinux@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh <linux-sh@vger.kernel.org>, Will Deacon <will>
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMTYgYXQgMDM6MTA6MzNQTSAtMDcwMCwgS2VlcyBDb29rIHdyb3Rl
Ogo+IE9uIEZyaSwgQXVnIDE5LCAyMDE2IGF0IDI6MzIgUE0sICA8bWNncm9mQGtlcm5lbC5vcmc+
IHdyb3RlOgo+ID4gZGlmZiAtLWdpdCBhL2luaXQvS2NvbmZpZyBiL2luaXQvS2NvbmZpZwo+ID4g
aW5kZXggY2FjM2YwOTYwNTBkLi5lZjA5ZTgzYjkxOTYgMTAwNjQ0Cj4gPiAtLS0gYS9pbml0L0tj
b25maWcKPiA+ICsrKyBiL2luaXQvS2NvbmZpZwo+ID4gQEAgLTUzLDYgKzUzLDI4IEBAIGNvbmZp
ZyBDUk9TU19DT01QSUxFCj4gPiAgICAgICAgICAgbmVlZCB0byBzZXQgdGhpcyB1bmxlc3MgeW91
IHdhbnQgdGhlIGNvbmZpZ3VyZWQga2VybmVsIGJ1aWxkCj4gPiAgICAgICAgICAgZGlyZWN0b3J5
IHRvIHNlbGVjdCB0aGUgY3Jvc3MtY29tcGlsZXIgYXV0b21hdGljYWxseS4KPiA+Cj4gPiArY29u
ZmlnIEJVSUxEX0FWT0lEX0JJVFJPVAo+ID4gKyAgICAgICBib29sICJFbmFibGUgZm9yY2UgYnVp
bGRpbmcgb2YgZm9yY2Utb2JqLXkgYW5kIGZvcmNlLWxpYi15Igo+IAo+IFNvcnJ5IHRvIGNvbnRp
bnVlIHRoZSBiaWtlc2hlZGRpbmcgb24gdGhpcywgYnV0IGlmIEkgZW5jb3VudGVyCj4gc29tZXRo
aW5nIGluIGEgTWFrZWZpbGUgbmFtZWQgImZvcmNlLW9iai15IiBJIHdvdWxkIGV4cGVjdCBpdCB0
bwo+IGFsd2F5cyBiZSBidWlsdCwgbm8gbWF0dGVyIHdoYXQuIEJ1dCB0aGlzIGlzIG5vdCB0aGUg
Y2FzZTogdGhlCj4gImZvcmNlLSIgcHJlZml4IGlzIHRpZWQgdG8gdGhpcyBDT05GSUdfQlVJTERf
QVZPSURfQklUUk9ULiBUaGlzIHZlcmIKPiB1c2FnZSBpcyB3ZWlyZCwgYXMgSSdkIGV4cGVjdCBh
biBhZGplY3RpdmUsIGxpa2UgImZvcmNlYWJsZS1vYmoteSIgb3IKPiBzb21ldGhpbmcgdGhhdCBk
ZXNjcmliZXMgdGhhdCBpdCBDQU4gYmUgYnVpbHQgZXZlbiB3aXRoIHRoZSBDT05GSUcgZm9yCj4g
aXQgaXMgbWlzc2luZywgZXRjLgo+IAo+IFJlZ2FyZGxlc3MsIEkgZGVmZXIgdG8gTWljaGFsIG9u
IHRoaXMsIGJ1dCBJJ20gbm90IGEgZmFuIG9mICJmb3JjZSIKPiBiZWluZyB1c2VkIHdoZW4gaXQn
cyBhbiBvcHRpb25hbCBhY3Rpb24uIDopCgpTdXJlLCBNaWNoYWwgbGV0IG1lIGtub3cgaWYgZm9y
Y2VhYmxlLW9iai15IGFuZCBmb3JjZWFibGUtbGliLXkgaXMgdGhlCndheSB0byBnby4KCiAgTHVp
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRl
dmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhl
bi5vcmcveGVuLWRldmVsCg==
