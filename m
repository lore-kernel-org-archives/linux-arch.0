Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-dm6nam12on2134.outbound.protection.outlook.com ([40.107.243.134]:18817
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbgCTRWU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 13:22:20 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Date: Fri, 20 Mar 2020 17:22:16 +0000
Message-ID: <MW2PR2101MB10521A71057BDEEDF2BB4F23D7F50@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
 <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
 <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
 <MW2PR2101MB10520CEF065A41EEBC17FFC2D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a1MfYDTiQ9j0o3tnd=ymZukPoSmuExLhEMRR+GRwVD7xA@mail.gmail.com>
In-Reply-To: <CAK8P3a1MfYDTiQ9j0o3tnd=ymZukPoSmuExLhEMRR+GRwVD7xA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Zyngier <maz@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <20200320172216.0zlPh1R1QURcU0Xq4ia33WJvRsu_Jhk73Gg3L3IVeAs@z>

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogRnJpZGF5LCBNYXJjaCAy
MCwgMjAyMCA5OjI4IEFNDQo+IA0KPiBPbiBUaHUsIE1hciAxOSwgMjAyMCBhdCAxMDo0MyBQTSBN
aWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4gRnJvbTog
QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxOCwg
MjAyMCAyOjU4IEFNDQo+ID4gPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAxOjE1IEFNIE1pY2hh
ZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiA+IE15IHBvaW50
IHdhcyB0byBrZWVwIHRoZSBmdW5jdGlvbnMgYnV0IHVzZSBhbGxvY19wYWdlcygpIGludGVybmFs
bHksDQo+ID4gPiBzbyB5b3UgY2FuIGRlYWwgd2l0aCB0aGUgaHlwZXJ2aXNvciBoYXZpbmcgYSBs
YXJnZXIgcGFnZSBzaXplIHRoYW4NCj4gPiA+IHRoZSBndWVzdCwgd2hpY2ggc2VlbXMgdG8gYmUg
YSBtb3JlIGltcG9ydGFudCBzY2VuYXJpbyBpZiBJIGNvcnJlY3RseQ0KPiA+ID4gdW5kZXJzdGFu
ZCB0aGUgZGlmZmVyZW5jZXMgYmV0d2VlbiB0aGUgd2F5IFdpbmRvd3MgYW5kIExpbnV4DQo+ID4g
PiBkZWFsIHdpdGggcGFnZSBjYWNoZS4NCj4gPg0KPiA+IE9LLCBJIHNlZSBub3cgd2hhdCB5b3Ug
YXJlIGdldHRpbmcgYXQuICBJIHNob3VsZCBzcGVsbCBvdXQgbXkNCj4gPiBhc3N1bXB0aW9uLCB3
aGljaCBpcyB0aGUgb3Bwb3NpdGUuICBIeXBlci1WIHdvbid0IGhhdmUgYSBwYWdlDQo+ID4gc2l6
ZSBvdGhlciB0aGFuIDRLIGFueXRpbWUgaW4gdGhlIGZvcmVzZWVhYmxlIGZ1dHVyZS4gIFRoZQ0K
PiA+IGNvZGUgaXMgdG9vIHdlZGRlZCB0byB0aGUgeDg2IDRLIHBhZ2Ugc2l6ZSwgYW5kIHRoZSBo
b3N0LWd1ZXN0DQo+ID4gaW50ZXJmYWNlcyBoYXZlIGEgbG90IG9mIGltcGxpY2l0IGFzc3VtcHRp
b25zIHRoYXQgdGhlIHBhZ2Ugc2l6ZSBpcw0KPiA+IDRLICh1bmZvcnR1bmF0ZWx5KS4gIEJ1dCB0
aGUgbGFzdCB0aW1lIEkgbG9va2VkLCBSSEVMIGZvciBBUk02NCBpcw0KPiA+IGRlbGl2ZXJlZCB3
aXRoIGEgNjRLIHBhZ2Ugc2l6ZS4gIFNvIG15IGFzc3VtcHRpb24gaXMgdGhhdCB0aGUgb25seQ0K
PiA+IGNvbWJpbmF0aW9uIHRoYXQgcmVhbGx5IG1hdHRlcnMgaXMgdGhlIGd1ZXN0IHBhZ2Ugc2l6
ZSBiZWluZyBsYXJnZXINCj4gPiB0aGFuIHRoZSBIeXBlci1WIHBhZ2Ugc2l6ZS4gIFRoZSBvdGhl
ciB3YXkgYXJvdW5kIGp1c3Qgd29uJ3QNCj4gPiBoYXBwZW4gd2l0aG91dCBhIG1ham9yIG92ZXJo
YXVsIHRvIEh5cGVyLVYsIGluY2x1ZGluZyBhIHJld29yaw0KPiA+IG9mIHRoZSBndWVzdC1ob3N0
IGludGVyZmFjZS4NCj4gDQo+IE9rLCBnb3QgaXQuIFdlIHNob3VsZCByZWFsbHkgYXNrIFJlZCBI
YXQgdG8gY2hhbmdlIHRoZSBwYWdlIHNpemUsDQo+IGJ1dCBhcyBsb25nIGFzIHlvdSBjYXJlIGV4
aXN0aW5nIHN5c3RlbXMsIGFuZCB5b3UgZXhwZWN0IHRoaXMgdG8NCj4gcmVzdWx0IGluIGdpZ2Fi
eXRlcyBvZiBhbGxvY2F0aW9uIG9uIGZ1dHVyZSBzeXN0ZW1zLCBoYXZpbmcgdGhlDQo+IHdyYXBw
ZXIgc2VlbXMgcmVhc29uYWJsZS4NCj4gDQo+IE1heWJlIHlvdSBjb3VsZCBmYWxsIGJhY2sgdG8g
YWxsb2NfcGFnZSB3aGVuIFBBR0VfU0laRSBlcXVhbHMNCj4gSFZfSFlQX1BBR0VfU0laRSB0aG91
Z2g/IEknbSBub3Qgc3VyZSB3aGF0IHRoZSB0cmFkZW9mZg0KPiBiZXR3ZWVuIGttYWxsb2MgYW5k
IGFsbG9jX3BhZ2UgaXMgdGhlc2UgZGF5cywgb3RoZXIgdGhhbiB0aGUNCj4gZmVlbGluZyB0aGF0
IGFsbG9jX3BhZ2UgaXMgdGhlIG1vcmUgb2J2aW91cyBjaG9pY2Ugd2hlbiB5b3Uga25vdw0KPiB5
b3UgYWx3YXlzIHdhbnQgZXhhY3RseSBhIHBhZ2UgaGVyZS4NCj4gDQoNClllcywgdGhhdCB3b3Jr
cyBmb3IgbWUuDQoNCk1pY2hhZWwNCg0KDQo=
