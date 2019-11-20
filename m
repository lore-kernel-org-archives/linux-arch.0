From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH 08/23] y2038: ipc: remove __kernel_time_t
 reference from headers
Date: Wed, 20 Nov 2019 22:49:19 +0000
Message-ID: <dd1a30609f05e800550097080c1d1b27065f91ff.camel@codethink.co.uk>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108210824.1534248-8-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <20191108210824.1534248-8-arnd@arndb.de>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S.
 Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCAyMDE5LTExLTA4IGF0IDIyOjA3ICswMTAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgpb
Li4uXQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20vc2VtYnVmLmgKPiArKysgYi9h
cmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL3NlbWJ1Zi5oCj4gQEAgLTIxLDkgKzIxLDkgQEAgc3Ry
dWN0IHNlbWlkNjRfZHMgewo+ICAJdW5zaWduZWQgbG9uZwlzZW1fY3RpbWU7CS8qIGxhc3QgY2hh
bmdlIHRpbWUgKi8KPiAgCXVuc2lnbmVkIGxvbmcJc2VtX2N0aW1lX2hpZ2g7Cj4gICNlbHNlCj4g
LQlfX2tlcm5lbF90aW1lX3QJc2VtX290aW1lOwkvKiBsYXN0IHNlbW9wIHRpbWUgKi8KPiArCWxv
bmcJCXNlbV9vdGltZTsJLyogbGFzdCBzZW1vcCB0aW1lICovCj4gIAlfX2tlcm5lbF91bG9uZ190
IF9fdW51c2VkMTsKPiAtCV9fa2VybmVsX3RpbWVfdAlzZW1fY3RpbWU7CS8qIGxhc3QgY2hhbmdl
IHRpbWUgKi8KPiArCWxvbmcJCXNlbV9jdGltZTsJLyogbGFzdCBjaGFuZ2UgdGltZSAqLwo+ICAJ
X19rZXJuZWxfdWxvbmdfdCBfX3VudXNlZDI7Cj4gICNlbmRpZgo+ICAJX19rZXJuZWxfdWxvbmdf
dCBzZW1fbnNlbXM7CS8qIG5vLiBvZiBzZW1hcGhvcmVzIGluIGFycmF5ICovClsuLi5dCgpXZSBu
ZWVkIHRvIHVzZSBfX2tlcm5lbF9sb25nX3QgaGVyZSB0byBkbyB0aGUgcmlnaHQgdGhpbmcgb24g
eDMyLgoKQmVuLgoKLS0gCkJlbiBIdXRjaGluZ3MsIFNvZnR3YXJlIERldmVsb3BlciAgICAgICAg
ICAgICAgICAgICAgICAgICBDb2RldGhpbmsgTHRkCmh0dHBzOi8vd3d3LmNvZGV0aGluay5jby51
ay8gICAgICAgICAgICAgICAgIERhbGUgSG91c2UsIDM1IERhbGUgU3RyZWV0CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBNYW5jaGVzdGVyLCBNMSAySEYsIFVuaXRlZCBLaW5n
ZG9tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAz
OCBtYWlsaW5nIGxpc3QKWTIwMzhAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFy
by5vcmcvbWFpbG1hbi9saXN0aW5mby95MjAzOAo=
