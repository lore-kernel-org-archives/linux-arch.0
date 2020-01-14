From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic
 __strnlen_user/__strncpy_from_user
Date: Tue, 14 Jan 2020 21:36:15 +0000
Message-ID: <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-5-vgupta@synopsys.com>
 <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:56924 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728656AbgANVhJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 16:37:09 -0500
In-Reply-To: <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
Content-Language: en-US
Content-ID: <3F5200B14FC6254BA227563B1C09096A@namprd12.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

T24gMS8xNC8yMCAxMjo0MiBQTSwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MTQsIDIwMjAgYXQgOTowOCBQTSBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMu
Y29tPiB3cm90ZToNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vd29y
ZC1hdC1hLXRpbWUuaCBiL2FyY2gvYXJjL2luY2x1ZGUvYXNtL3dvcmQtYXQtYS10aW1lLmgNCj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjAwZTkyYmU3MDk4
Nw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vd29yZC1h
dC1hLXRpbWUuaA0KPj4gQEAgLTAsMCArMSw0OSBAQA0KPj4gKy8qIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCj4+ICsvKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAy
MCBTeW5vcHN5cyBJbmMuDQo+PiArICovDQo+PiArI2lmbmRlZiBfX0FTTV9BUkNfV09SRF9BVF9B
X1RJTUVfSA0KPj4gKyNkZWZpbmUgX19BU01fQVJDX1dPUkRfQVRfQV9USU1FX0gNCj4+ICsNCj4+
ICsjaWZkZWYgX19MSVRUTEVfRU5ESUFOX18NCj4+ICsNCj4+ICsjaW5jbHVkZSA8bGludXgva2Vy
bmVsLmg+DQo+PiArDQo+PiArc3RydWN0IHdvcmRfYXRfYV90aW1lIHsNCj4+ICsgICAgICAgY29u
c3QgdW5zaWduZWQgbG9uZyBvbmVfYml0cywgaGlnaF9iaXRzOw0KPj4gK307DQo+IA0KPiBXaGF0
J3Mgd3Jvbmcgd2l0aCB0aGUgZ2VuZXJpYyB2ZXJzaW9uIG9uIGxpdHRsZS1lbmRpYW4/IEFueQ0K
PiBjaGFuY2UgeW91IGNhbiBmaW5kIGEgd2F5IHRvIG1ha2UgaXQgd29yayBhcyB3ZWxsIGZvciB5
b3UgYXMNCj4gdGhpcyBjb3B5Pw0KDQpmaW5kX3plcm8oKSBieSBkZWZhdWx0IGRvZXNuJ3QgdXNl
IHBvcCBjb3VudCBpbnN0cnVjdGlvbnMuIEkgZGlkbid0IGxpa2UgdGhlIGNvcHkNCmVpdGhlciBi
dXQgd2Fzbid0IHN1cmUgb2YgdGhlIGJlc3Qgd2F5IHRvIG1ha2UgdGhpcyA0IEFQSSBpbnRlcmZh
Y2UgcmV1c2FibGUuIEFyZQ0KeW91IHN1Z2dlc3Rpbmcgd2UgYWxsb3cgcGFydGlhbCBvdmVyLXJp
ZGUgc3RhcnRpbmcgd2l0aCAjaWZuZGVmIGZpbmRfemVybyA/DQoNCj4+ICtzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGxvbmcgZmluZF96ZXJvKHVuc2lnbmVkIGxvbmcgbWFzaykNCj4+ICt7DQo+PiAr
I2lmZGVmIENPTkZJR182NEJJVA0KPj4gKyAgICAgICByZXR1cm4gZmxzNjQobWFzaykgPj4gMzsN
Cj4+ICsjZWxzZQ0KPj4gKyAgICAgICByZXR1cm4gZmxzKG1hc2spID4+IDM7DQo+PiArI2VuZGlm
DQo+IA0KPiBUaGUgQ09ORklHXzY0QklUIGNoZWNrIG5vdCBiZSBuZWVkZWQsIHVubGVzcyB5b3Ug
YXJlIGFkZGluZw0KPiBzdXBwb3J0IGZvciA2NC1iaXQgQVJDIHJlYWxseSBzb29uLg0KDQo6LSkg
SW5kZWVkIHRoYXQgd2FzIHRoZSBwcmVtaXNlICENCg0KVGh4IGZvciB0aGUgcXVpY2sgcmV2aWV3
Lg0KDQotVmluZWV0DQo=
