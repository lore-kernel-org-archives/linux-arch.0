Return-Path: <SRS0=mIjk=5D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-eopbgr770101.outbound.protection.outlook.com ([40.107.77.101]:27902
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgCRASm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:18:42 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 09/10] arm64: efi: Export screen_info
Date: Wed, 18 Mar 2020 00:18:39 +0000
Message-ID: <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <20200318001839.jUttYFnu8wxcF2X1exj9YGriWCCJ7mbvf6gjvrfodJ4@z>

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IE9uIFNhdCwgTWFyIDE0
LCAyMDIwIGF0IDQ6MzYgUE0gTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gVGhlIEh5cGVyLVYgZnJhbWUgYnVmZmVyIGRyaXZlciBtYXkgYmUg
YnVpbHQgYXMgYSBtb2R1bGUsIGFuZA0KPiA+IGl0IG5lZWRzIGFjY2VzcyB0byBzY3JlZW5faW5m
by4gU28gZXhwb3J0IHNjcmVlbl9pbmZvLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+IA0KPiBJcyB0aGVyZSBhbnkgY2hh
bmNlIG9mIHVzaW5nIGEgbW9yZSBtb2Rlcm4gS01TIGJhc2VkIGRyaXZlciBmb3IgdGhlIHNjcmVl
bg0KPiB0aGFuIHRoZSBvbGQgZmJkZXYgc3Vic3lzdGVtPyBJIGhhZCBob3BlZCB0byBvbmUgZGF5
IGNvbXBsZXRlbHkgcmVtb3ZlDQo+IHN1cHBvcnQgZm9yIHRoZSBvbGQgQ09ORklHX1ZJREVPX0ZC
REVWIGFuZCBzY3JlZW5faW5mbyBmcm9tIG1vZGVybg0KPiBhcmNoaXRlY3R1cmVzLg0KPiANCg0K
VGhlIGN1cnJlbnQgaHlwZXJ2X2ZiLmMgZHJpdmVyIGlzIGFsbCB3ZSBoYXZlIHRvZGF5IGZvciB0
aGUgc3ludGhldGljIEh5cGVyLVYNCmZyYW1lIGJ1ZmZlciBkZXZpY2UuICBUaGF0IGRyaXZlciBi
dWlsZHMgYW5kIHJ1bnMgb24gYm90aCBBUk02NCBhbmQgeDg2Lg0KDQpJJ20gbm90IGtub3dsZWRn
ZWFibGUgYWJvdXQgdmlkZW8vZ3JhcGhpY3MgZHJpdmVycywgYnV0IHdoZW4geW91DQpzYXkgImEg
bW9yZSBtb2Rlcm4gS01TIGJhc2VkIGRyaXZlciIsIGFyZSB5b3UgbWVhbmluZyBvbmUgYmFzZWQg
b24NCkRSTSAmIEtNUz8gIERvZXMgRFJNIG1ha2Ugc2Vuc2UgZm9yIGEgImR1bWIiIGZyYW1lIGJ1
ZmZlciBkZXZpY2U/DQpBcmUgdGhlcmUgYW55IGRyaXZlcnMgdGhhdCB3b3VsZCBiZSBhIGdvb2Qg
cGF0dGVybiB0byBsb29rIGF0Pw0KDQpNaWNoYWVsDQoNCg==
