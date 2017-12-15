From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] include: Add new y2038 safe
	__kernel_timespec
Date: Fri, 15 Dec 2017 11:36:01 +0100
Message-ID: <CAK8P3a29Nh6bK4tgNM8PxUCj_XnzU71vZR992=E5MUUFkSjPNg@mail.gmail.com>
References: <20171127193037.8711-1-deepa.kernel@gmail.com>
 <20171127193037.8711-8-deepa.kernel@gmail.com>
 <1513296698.18523.291.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <1513296698.18523.291.camel@codethink.co.uk>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, GNU C Library <libc-alpha@sourceware.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Albert ARIBAUD <albert.aribaud@3adev.fr>, John Stultz <john.stultz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBEZWMgMTUsIDIwMTcgYXQgMToxMSBBTSwgQmVuIEh1dGNoaW5ncwo8YmVuLmh1dGNo
aW5nc0Bjb2RldGhpbmsuY28udWs+IHdyb3RlOgo+IE9uIE1vbiwgMjAxNy0xMS0yNyBhdCAxMToz
MCAtMDgwMCwgRGVlcGEgRGluYW1hbmkgd3JvdGU6Cj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51
eC90aW1lLmgKPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3RpbWUuaAo+PiBAQCAtNDIsNiAr
NDIsMTMgQEAgc3RydWN0IGl0aW1lcnZhbCB7Cj4+ID4gPiAgIHN0cnVjdCB0aW1ldmFsIGl0X3Zh
bHVlOyAgICAgICAgLyogY3VycmVudCB2YWx1ZSAqLwo+PiAgfTsKPj4KPj4gKyNpZm5kZWYgX19r
ZXJuZWxfdGltZXNwZWMKPj4gK3N0cnVjdCBfX2tlcm5lbF90aW1lc3BlYyB7Cj4+ICsgICAgIF9f
a2VybmVsX3RpbWU2NF90ICAgICAgIHR2X3NlYzsgICAgICAgICAgICAgICAgIC8qIHNlY29uZHMg
Ki8KPj4gKyAgICAgbG9uZyBsb25nICAgICAgICAgICAgICAgdHZfbnNlYzsgICAgICAgICAgICAg
ICAgLyogbmFub3NlY29uZHMgKi8KPj4gK307Cj4+ICsjZW5kaWYKPgo+IEkgd29uZGVyIGlmIGl0
IG1ha2VzIHNlbnNlIHRvIG92ZXJyaWRlIHRoZSBhbGlnbm1lbnQgb2YgdGhpcyBzdHJ1Y3R1cmU/
Cj4gICg2NC1iaXQgdHlwZXMgYXJlIGFsaWduZWQgZGlmZmVyZW50bHkgb24gMzItYml0IHZzIDY0
LWJpdCB4ODYsIGJ1dCBub3QKPiBvdGhlciBjb21wYXQgY2FzZXMuKSAgSXQgbWlnaHQgcmVkdWNl
IHRoZSBuZWVkIGZvciBjb252ZXJzaW9ucyBpbgo+IGNvbXBhdCBjb2RlIGVsc2V3aGVyZSBsYXRl
ci4KCkkgdGhpbmsgdGhlIGFsaWdubWVudCBoZXJlIHNob3VsZCBiZSBhZ3JlZWQgd2l0aCBnbGli
YyBzbyB0aGV5IHVzZSB0aGUKc2FtZSBhbGlnbm1lbnQgZm9yIHRoZWlyIG5ldyB0aW1lc3BlYy4g
SSBkb24ndCBzZWUgYSBzcGVjaWZpYyBtZW50aW9uCm9mIHRoaXMgYXQKaHR0cHM6Ly9zb3VyY2V3
YXJlLm9yZy9nbGliYy93aWtpL1kyMDM4UHJvb2ZuZXNzRGVzaWduI3N0cnVjdF9fX3RpbWVzcGVj
NjQKc28gSSdtIGFkZGluZyBBbGJlcnQgYW5kIGxpYmMtYWxwaGEgdG8gQ2MgZm9yIGNsYXJpZmlj
YXRpb24uCgpJIGFncmVlIGl0IHdvdWxkIHNpbXBsaWZ5IHRoaW5ncyBhIGJpdCB0byBlbnN1cmUg
dGhhdCB0aW1lNjRfdCBhbmQKX190aW1lc3BlYzY0L19fa2VybmVsX3RpbWVzcGVjIGhhdmUgYSA2
NC1iaXQgYWxpZ25tZW50IGV2ZW4gb24KeDg2LTMyLCBidXQgSSBkb24ndCBrbm93IGlmIHRoZXJl
IGlzIHByZWNlZGVudCBmb3IgdXNpbmcgZ2NjCl9fYXR0cmlidXRlX18oKGFsaWduZWQoOCkpIG9u
IFBPU0lYIGRhdGEgdHlwZXMsIG9mIGlmIHRoYXQgbWlnaHQKY2F1c2UgcHJvYmxlbXMgZS5nLiBm
b3Igbm9uLWdudSBjb21waWxlcnMuCgogICAgICAgQXJuZApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAzOCBtYWlsaW5nIGxpc3QKWTIwMzhAbGlzdHMu
bGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0aW5mby95MjAz
OAo=
