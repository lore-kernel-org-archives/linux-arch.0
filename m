Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:58544 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgANWOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 17:14:40 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic
 __strnlen_user/__strncpy_from_user
Date: Tue, 14 Jan 2020 22:14:31 +0000
Message-ID: <67715aba-fa40-1f46-288d-391d086328ac@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-5-vgupta@synopsys.com>
 <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
 <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
 <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
In-Reply-To: <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <482E57B4610060459E6825AB481A2823@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200114221431.MMHpEerf0wQHiPU1OOc4X66WmjmvsdHZUId7T970bNc@z>

T24gMS8xNC8yMCAxOjQ5IFBNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MTQsIDIwMjAgYXQgMTozNyBQTSBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMu
Y29tPiB3cm90ZToNCj4+DQo+PiBPbiAxLzE0LzIwIDEyOjQyIFBNLCBBcm5kIEJlcmdtYW5uIHdy
b3RlOg0KPj4+DQo+Pj4gV2hhdCdzIHdyb25nIHdpdGggdGhlIGdlbmVyaWMgdmVyc2lvbiBvbiBs
aXR0bGUtZW5kaWFuPyBBbnkNCj4+PiBjaGFuY2UgeW91IGNhbiBmaW5kIGEgd2F5IHRvIG1ha2Ug
aXQgd29yayBhcyB3ZWxsIGZvciB5b3UgYXMNCj4+PiB0aGlzIGNvcHk/DQo+Pg0KPj4gZmluZF96
ZXJvKCkgYnkgZGVmYXVsdCBkb2Vzbid0IHVzZSBwb3AgY291bnQgaW5zdHJ1Y3Rpb25zLg0KPiAN
Cj4gRG9uJ3QgeW91IHRoaW5rIHRoZSBnZW5lcmljIGZpbmRfemVybygpIGlzIGxpa2VseSBqdXN0
IGFzIGZhc3QgYXMgdGhlDQo+IHBvcCBjb3VudCBpbnN0cnVjdGlvbj8gT24gMzItYml0LCBJIHRo
aW5rIGl0J3MgbGlrZSBhIHNoaWZ0IGFuZCBhIG1hc2sNCj4gYW5kIGEgY291cGxlIG9mIGFkZGl0
aW9ucy4NCg0KWW91IGFyZSByaWdodCB0aGF0IGluIGdyYW5kIHNjaGVtZSB0aGluZ3MgaXQgbWF5
IGJlIGxlc3MgdGhhbiBub2lzZS4NCg0KQVJDIHBvcCBjb3VudCB2ZXJzaW9uDQoNCiMgCWJpdHMg
PSAoYml0cyAtIDEpICYgfmJpdHM7DQojICAJcmV0dXJuIGJpdHMgPj4gNzsNCg0KCXN1YiByMCxy
NiwxDQoJYmljIHI2LHIwLHI2DQoJbHNyIHIwLHI2LDcNCg0KIyAJcmV0dXJuIGZscyhtYXNrKSA+
PiAzOw0KDQoJZmxzLmYJcjAsIHIwDQoJYWRkLm56CXIwLCByMCwgMQ0KCWFzciByNSxyMCwzDQoN
CglqX3MuZCBbYmxpbmtdDQoNCkdlbmVyaWMgdmVyc2lvbg0KDQojIAliaXRzID0gKGJpdHMgLSAx
KSAmIH5iaXRzOw0KIyAgCXJldHVybiBiaXRzID4+IDc7DQoNCglzdWIgcjUscjYsMQ0KCWJpYyBy
NixyNSxyNg0KCWxzciByNSxyNiw3DQoNCiMgIAl1bnNpZ25lZCBsb25nIGEgPSAoMHgwZmYwMDAx
K21hc2spID4+IDIzOw0KIyAJcmV0dXJuIGEgJiBtYXNrOw0KDQoJYWRkIHIwLHI1LDB4MGZmMDAw
MQk8LS0gdGhpcyBpcyA4IGJ5dGUgaW5zdHJ1Y3Rpb24gdGhvdWdoDQoJbHNyX3MgcjAscjAsMjMN
CglhbmQgcjUscjUscjANCg0KCWpfcy5kIFtibGlua10NCg0KDQpCdXQgaXRzIHRoZSB1c3VhbCBp
dGNoL2luY2xpbmF0aW9uIG9mIGFyY2ggcGVvcGxlIHRvIHRyeSBhbmQgdXNlIHRoZSBzcGVjaWZp
Yw0KaW5zdHJ1Y3Rpb24gaWYgYXZhaWxhYmxlLg0KDQo+IA0KPiBUaGUgNjQtYml0IGNhc2UgaGFz
IGEgbXVsdGlwbHkgdGhhdCBpcyBsaWtlbHkgZXhwZW5zaXZlIHVubGVzcyB5b3UNCj4gaGF2ZSBh
IGdvb2QgbXVsdGlwbGljYXRpb24gdW5pdCAoYnV0IHdoYXQgNjQtYml0IGFyY2hpdGVjdHVyZQ0K
PiBkb2Vzbid0PyksIGJ1dCB0aGUgZ2VuZXJpYyAzMi1iaXQgTEUgY29kZSBzaG91bGQgYWxyZWFk
eSBiZSBwcmV0dHkNCj4gY2xvc2UgdG8gb3B0aW1hbCwgYW5kIGl0IG1pZ2h0IG5vdCBiZSB3b3J0
aCBpdCB0byB3b3JyeSBhYm91dCBpdC4NCj4gDQo+IChUaGUgYmlnLWVuZGlhbiBjYXNlIGlzIHZl
cnkgZGlmZmVyZW50LCBhbmQgYXJjaGl0ZWN0dXJlcyByZWFsbHkgY2FuDQo+IGRvIG11Y2ggYmV0
dGVyLiBCdXQgTEUgYWxsb3dzIGZvciBiaXQgdHJpY2tzIHVzaW5nIHRoZSBjYXJyeSBjaGFpbikN
Cg0KLVZpbmVldA0K
