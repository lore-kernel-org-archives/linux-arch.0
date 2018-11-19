From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 3/5] mips: remove syscall table entries
Date: Mon, 19 Nov 2018 22:29:29 +0000
Message-ID: <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Content-ID: <048540EEEDA7B04DAE7C3A95B96AB90D@namprd22.prod.outlook.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, James Hogan <jhogan@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

SGkgRmlyb3osCgpPbiBUaHUsIE5vdiAxNSwgMjAxOCBhdCAxMTo0NDoxOUFNICswNTMwLCBGaXJv
eiBLaGFuIHdyb3RlOgo+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMva2VybmVsL3NjYWxsMzItbzMy
LlMgYi9hcmNoL21pcHMva2VybmVsL3NjYWxsMzItbzMyLlMKPiBpbmRleCBhOWI4OTVmLi40ZWVl
NDM3IDEwMDY0NAo+IC0tLSBhL2FyY2gvbWlwcy9rZXJuZWwvc2NhbGwzMi1vMzIuUwo+ICsrKyBi
L2FyY2gvbWlwcy9rZXJuZWwvc2NhbGwzMi1vMzIuUwo+IEBAIC0yMDgsNiArMjA4LDE4IEBAIGVp
bnZhbDogbGkJdjAsIC1FTk9TWVMKPiAgCWpyCXJhCj4gIAlFTkQoc3lzX3N5c2NhbGwpCj4gIAo+
ICsjaWZkZWYgQ09ORklHX01JUFNfTVRfRlBBRkYKPiArCS8qCj4gKwkgKiBGb3IgRlBVIGFmZmlu
aXR5IHNjaGVkdWxpbmcgb24gTUlQUyBNVCBwcm9jZXNzb3JzLCB3ZSBuZWVkIHRvCj4gKwkgKiBp
bnRlcmNlcHQgc3lzX3NjaGVkX3h4eGFmZmluaXR5KCkgY2FsbHMgdW50aWwgd2UgZ2V0IGEgcHJv
cGVyIGhvb2sKPiArCSAqIGluIGtlcm5lbC9zY2hlZC9jb3JlLmMuICBDb25zaWRlcmVkIG9ubHkg
dGVtcG9yYXJ5IHdlIG9ubHkgc3VwcG9ydAo+ICsJICogdGhlc2UgaG9va3MgZm9yIHRoZSAzMi1i
aXQga2VybmVsIC0gdGhlcmUgaXMgbm8gTUlQUzY0IE1UIHByb2Nlc3Nvcgo+ICsJICogYXRtLgo+
ICsJICovCj4gKyNkZWZpbmUgbWlwc210X3N5c19zY2hlZF9zZXRhZmZpbml0eSBzeXNfc2NoZWRf
c2V0YWZmaW5pdHkKPiArI2RlZmluZSBtaXBzbXRfc3lzX3NjaGVkX2dldGFmZmluaXR5IHN5c19z
Y2hlZF9nZXRhZmZpbml0eQoKSXMgdGhpcyBiYWNrd2FyZHM/IGllLiBzaG91bGQgaXQgYmU6Cgog
ICAgI2RlZmluZSBzeXNfc2NoZWRfc2V0YWZmaW5pdHkgbWlwc210X3N5c19zY2hlZF9zZXRhZmZp
bml0eQogICAgI2RlZmluZSBzeXNfc2NoZWRfZ2V0YWZmaW5pdHkgbWlwc210X3N5c19zY2hlZF9n
ZXRhZmZpbml0eQoKPwoKSSBkb24ndCBzZWUgaG93IHRoZSBtaXBzbXRfKiBmdW5jdGlvbnMgd2ls
bCBldmVyIGJlIHVzZWQgYWZ0ZXIgdGhpcwpwYXRjaC4KClRoYW5rcywKICAgIFBhdWwKCj4gKyNl
bmRpZiAvKiBDT05GSUdfTUlQU19NVF9GUEFGRiAqLwo+ICsKPiAgCS5hbGlnbgkyCj4gIAkudHlw
ZQlzeXNfY2FsbF90YWJsZSwgQG9iamVjdAo+ICBFWFBPUlQoc3lzX2NhbGxfdGFibGUpCj4gQEAg
LTQ1MCwyMCArNDYyLDggQEAgRVhQT1JUKHN5c19jYWxsX3RhYmxlKQo+ICAJUFRSCXN5c190a2ls
bAo+ICAJUFRSCXN5c19zZW5kZmlsZTY0Cj4gIAlQVFIJc3lzX2Z1dGV4Cj4gLSNpZmRlZiBDT05G
SUdfTUlQU19NVF9GUEFGRgo+IC0JLyoKPiAtCSAqIEZvciBGUFUgYWZmaW5pdHkgc2NoZWR1bGlu
ZyBvbiBNSVBTIE1UIHByb2Nlc3NvcnMsIHdlIG5lZWQgdG8KPiAtCSAqIGludGVyY2VwdCBzeXNf
c2NoZWRfeHh4YWZmaW5pdHkoKSBjYWxscyB1bnRpbCB3ZSBnZXQgYSBwcm9wZXIgaG9vawo+IC0J
ICogaW4ga2VybmVsL3NjaGVkL2NvcmUuYy4gIENvbnNpZGVyZWQgb25seSB0ZW1wb3Jhcnkgd2Ug
b25seSBzdXBwb3J0Cj4gLQkgKiB0aGVzZSBob29rcyBmb3IgdGhlIDMyLWJpdCBrZXJuZWwgLSB0
aGVyZSBpcyBubyBNSVBTNjQgTVQgcHJvY2Vzc29yCj4gLQkgKiBhdG0uCj4gLQkgKi8KPiAtCVBU
UgltaXBzbXRfc3lzX3NjaGVkX3NldGFmZmluaXR5Cj4gLQlQVFIJbWlwc210X3N5c19zY2hlZF9n
ZXRhZmZpbml0eQo+IC0jZWxzZQo+ICAJUFRSCXN5c19zY2hlZF9zZXRhZmZpbml0eQo+ICAJUFRS
CXN5c19zY2hlZF9nZXRhZmZpbml0eQkJLyogNDI0MCAqLwo+IC0jZW5kaWYgLyogQ09ORklHX01J
UFNfTVRfRlBBRkYgKi8KPiAgCVBUUglzeXNfaW9fc2V0dXAKPiAgCVBUUglzeXNfaW9fZGVzdHJv
eQo+ICAJUFRSCXN5c19pb19nZXRldmVudHMKPiAtLSAKPiAxLjkuMQo+IApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAzOCBtYWlsaW5nIGxpc3QKWTIw
MzhAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0
aW5mby95MjAzOAo=
