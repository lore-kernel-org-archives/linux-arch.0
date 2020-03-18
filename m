Return-Path: <SRS0=mIjk=5D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-eopbgr770100.outbound.protection.outlook.com ([40.107.77.100]:38157
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727114AbgCRAQ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:16:28 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 05/10] arm64: hyperv: Add interrupt handlers for VMbus
 and stimer
Date: Wed, 18 Mar 2020 00:16:24 +0000
Message-ID: <MW2PR2101MB1052B9C24DAB19FBBD818347D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-6-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2yve3R1w5igBYMy3HSFJ8Xt4BHhXQcaTAkNCdZXZ1v-w@mail.gmail.com>
In-Reply-To: <CAK8P3a2yve3R1w5igBYMy3HSFJ8Xt4BHhXQcaTAkNCdZXZ1v-w@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <20200318001624.H_8aYpNcGlmVLW3KBhmI-eSt1Wfg0EPk8EHxFengbvg@z>

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IE9uIFNhdCwgTWFyIDE0
LCAyMDIwIGF0IDQ6MzYgUE0gTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gQWRkIEFSTTY0LXNwZWNpZmljIGNvZGUgdG8gc2V0IHVwIGFuZCBo
YW5kbGUgdGhlIGludGVycnVwdHMNCj4gPiBnZW5lcmF0ZWQgYnkgSHlwZXItViBmb3IgVk1idXMg
bWVzc2FnZXMgYW5kIGZvciBzdGltZXIgZXhwaXJhdGlvbi4NCj4gPg0KPiA+IFRoaXMgY29kZSBp
cyBhcmNoaXRlY3R1cmUgZGVwZW5kZW50IGFuZCBpcyBtb3N0bHkgZHJpdmVuIGJ5DQo+ID4gYXJj
aGl0ZWN0dXJlIGluZGVwZW5kZW50IGNvZGUgaW4gdGhlIFZNYnVzIGRyaXZlciBhbmQgdGhlDQo+
ID4gSHlwZXItViB0aW1lciBjbG9ja3NvdXJjZSBkcml2ZXIuDQo+ID4NCj4gPiBUaGlzIGNvZGUg
aXMgYnVpbHQgb25seSB3aGVuIENPTkZJR19IWVBFUlYgaXMgZW5hYmxlZC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiAN
Cj4gVGhpcyBsb29rcyBsaWtlIGl0IHNob3VsZCBiZSBhIG5lc3RlZCBpcnFjaGlwIGRyaXZlciBp
bnN0ZWFkLCBzbyB5b3VyDQo+IGRldmljZSBkcml2ZXJzIGNhbiB1c2UgdGhlIG5vcm1hbCByZXF1
ZXN0X2lycSgpIGZ1bmN0aW9ucyBldGMuDQo+IA0KPiBJcyBhbnl0aGluZyBwcmV2ZW50aW5nIHlv
dSBmcm9tIGRvaW5nIHRoYXQ/IElmIHNvLCBwbGVhc2UgZGVzY3JpYmUNCj4gdGhhdCBpbiB0aGUg
Y2hhbmdlbG9nIGFuZCBpbiBhIGNvbW1lbnQgaW4gdGhlIGRyaXZlci4NCj4gDQoNCkFzIG1lbnRp
b25lZCBpbiBteSByZXBseSBvbiBQYXRjaCAxLCBIeXBlci1WIG9mZmVycyBhIGxpbWl0ZWQgc3lu
dGhldGljDQppbnRlcnJ1cHQgY29udHJvbGxlciBtYW5hZ2VkIGJ5IExpbnV4IGNvZGUgdGhhdCdz
IGJlZW4gYXJvdW5kIHRoZSBsYXN0DQoxMCB5ZWFycyBvbiB0aGUgeDg2IHNpZGUuICAgRm9yIHJl
YXNvbnMgdGhhdCBwcmUtZGF0ZSBtZSwgaXQgd2FzIG5vdCB3cml0dGVuDQphcyBhbiBpcnFjaGlw
IGRyaXZlci4NCg0KTW9kdWxvIHRoZSBzbWFsbCByb3V0aW5lcyB5b3Ugc2VlIGluIHRoaXMgcGF0
Y2gsIHRoZSBjb2RlIGlzIGFyY2hpdGVjdHVyZQ0KaW5kZXBlbmRlbnQsIGFuZCBpdCBzZWVtcyB3
ZSBvdWdodCB0byBrZWVwIHRoZSBoaWdoIGRlZ3JlZSBvZiBjb21tb25hbGl0eS4NClJlLWFyY2hp
dGVjdGluZyB0aGUgYXJjaCBpbmRlcGVuZGVudCBjb2RlIHRvIG1vZGVsIGFzIGFuIGlycWNoaXAg
ZHJpdmVyIHNlZW1zDQp0byBjYXJyeSBzb21lIHJpc2sgdG8gdGhlIHg4NiBzaWRlIHRoYXQgaGFz
IGEgbG90IG9mIHJlYWwtd29ybGQgdXNhZ2UgdG9kYXksIGJ1dA0KSSdsbCB0YWtlIGEgbG9vayBh
bmQgc2VlIHdoYXQgdGhlIHJpc2tzIGxvb2sgbGlrZSBhbmQgaWYgaXQgYWRkcyBhbnkgY2xhcml0
eS4NCg==
