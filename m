From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 07/10] arm64: hyperv: Initialize hypervisor on boot
Date: Wed, 18 Mar 2020 00:17:52 +0000
Message-ID: <MW2PR2101MB1052281E5B197F2AA8E4D622D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
 <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn8nam12on2136.outbound.protection.outlook.com ([40.107.237.136]:2010
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbgCRASD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:18:03 -0400
In-Reply-To: <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@>

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogTW9uZGF5LCBNYXJjaCAx
NiwgMjAyMCAxOjMwIEFNDQo+IA0KPiBPbiBTYXQsIE1hciAxNCwgMjAyMCBhdCA0OjM2IFBNIE1p
Y2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFk
ZCBBUk02NC1zcGVjaWZpYyBjb2RlIHRvIGluaXRpYWxpemUgdGhlIEh5cGVyLVYNCj4gPiBoeXBl
cnZpc29yIHdoZW4gYm9vdGluZyBhcyBhIGd1ZXN0IFZNLiBQcm92aWRlIGZ1bmN0aW9ucw0KPiA+
IGFuZCBkYXRhIHN0cnVjdHVyZXMgaW5kaWNhdGluZyBoeXBlcnZpc29yIHN0YXR1cyB0aGF0DQo+
ID4gYXJlIG5lZWRlZCBieSBWTWJ1cyBkcml2ZXIuDQo+ID4NCj4gPiBUaGlzIGNvZGUgaXMgYnVp
bHQgb25seSB3aGVuIENPTkZJR19IWVBFUlYgaXMgZW5hYmxlZC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBhcmNoL2FybTY0L2h5cGVydi9odl9jb3JlLmMgfCAxNTYNCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gDQo+IEFzIHlvdSBhcmUgZWZmZWN0aXZl
bHkgYWRkaW5nIGEgbmV3IGNsb2Nrc291cmNlIGRyaXZlciBoZXJlLCBwbGVhc2UgbW92ZSB0aGUN
Cj4gY29kZSB0byBkcml2ZXJzL2Nsb2Nrc291cmNlIGFuZCBzZW5kIHRoZSBwYXRjaCB0byB0aGUg
cmVzcGVjdGl2ZSBtYWludGFpbmVycw0KPiAoYWRkZWQgdG8gQ2MgaGVyZSksIHNwbGl0dGluZyBp
dCBvdXQgZnJvbSB0aGUgcmVzdCBvZiB0aGUgcGF0Y2guDQo+IA0KPiBZb3Ugc2hvdWxkIGFsc28g
ZGVzY3JpYmUgd2h5IHlvdXIgcGxhdGZvcm0gZG9lc24ndCBqdXN0IHVzZSB0aGUgbm9ybWFsDQo+
IGFyY2hpdGVjdGVkIHRpbWVyIGludGVyZmFjZS4NCj4gDQo+ID4gK1RJTUVSX0FDUElfREVDTEFS
RShoeXBlcnYsIEFDUElfU0lHX0dURFQsIGh5cGVydl9pbml0KTsNCj4gDQo+IFRoaXMgbG9va3Mg
bGlrZSBpdCByZWdpc3RlcnMgYSBkcml2ZXIgZm9yIHRoZSBzYW1lIGRldmljZSBhcyB0aGUgbm9y
bWFsDQo+IGFyY2ggdGltZXIuIFdvbid0IHRoYXQgY2xhc2g/DQo+IA0KPiAgICAgIEFybmQNCg0K
VGhlcmUgaXMgYSBIeXBlci1WIGNsb2Nrc291cmNlIGRyaXZlciBpbiBkcml2ZXJzL2Nsb2Nrc291
cmNlL2h5cGVydl90aW1lci5jLg0KSXQgaXMgYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IGFuZCB3
b3JrcyBmb3IgYm90aCB4ODYgYW5kIEFSTTY0Lg0KDQpUaGUgcmVxdWlyZW1lbnQgaGVyZSBpcyBy
ZWFsbHkgZm9yIGEgcGxhY2UgdG8gaGFuZyB0aGUgZ2VuZXJhbCBIeXBlci1WDQppbml0aWFsaXph
dGlvbiBjb2RlLiAgIE9uIHRoZSB4ODYgc2lkZSwgdGhlcmUncyBpbmZyYXN0cnVjdHVyZSBhbHJl
YWR5IGluIHBsYWNlDQp0byBkbyBoeXBlcnZpc29yIGluaXRpYWxpemF0aW9uLCBidXQgbm90aGlu
ZyBjb3JyZXNwb25kaW5nIG9uIHRoZSBBUk02NCBzaWRlLg0KVGhlIFRJTUVSX0FDUElfREVDTEFS
RSBob29rIGlzIGFkbWl0dGVkbHkgYSB0ZW1wb3JhcnkgYXBwcm9hY2gsIGFuZCBJJ20NCmhhcHB5
IHRvIGhlYXIgaWYgc29tZW9uZSBoYXMgYSBiZXR0ZXIgd2F5IHRvIGhhbmRsZSB0aGlzLg0KDQpG
V0lXLCBIeXBlci1WIGRvZXNuJ3QgY3VycmVudGx5IHZpcnR1YWxpemUgdGhlIEFSTSBhcmNoIGNv
dW50ZXIvdGltZXIgZm9yDQpndWVzdCBWTXMuICBUaGUgSHlwZXItViBzeW50aGV0aWMgY291bnRl
ci90aW1lciBpbiB0aGUgSHlwZXItViBjbG9ja3NvdXJjZQ0KZHJpdmVyIGlzIHVzZWQgb24gYm90
aCBBUk02NCBhbmQgeDg2LiAgQnV0IHRoaXMgSHlwZXItViBpbml0IGNvZGUgZG9lc24ndCBhY3R1
YWxseQ0KdG91Y2ggdGhlIEdURFQgZGV2aWNlLCBzbyBpdCB3b24ndCBpbnRlcmZlcmUgd2l0aCB0
aGUgQVJNIGFyY2ggY291bnRlci90aW1lcg0Kd2hlbiBhIGZ1dHVyZSBIeXBlci1WIHZlcnNpb24g
ZG9lcyB2aXJ0dWFsaXplIGl0Lg0KDQpNaWNoYWVsDQo=
