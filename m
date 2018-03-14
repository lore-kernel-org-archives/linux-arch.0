From: "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
Date: Wed, 14 Mar 2018 14:38:00 +0000
Message-ID: <1521038277.2693.131.camel@hpe.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
Content-Language: en-US
Content-ID: <5C99D1C06EF2B3428FA0FC72FB6CB5DB@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>, "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCAyMDE4LTAzLTE0IGF0IDE0OjE4ICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gTm90ZTogSSB3YXMgd29ya2luZyBvbiB0aGVzZSBwYXRjaGVzIGZvciBxdWl0ZSBzb21ldGlt
ZQ0KPiBhbmQgcmVhbGl6ZWQgdGhhdCBUb3NoaSBLYW5pIGhhcyBzaGFyZWQgc29tZSBwYXRjaGVz
DQo+IGFkZHJlc3NpbmcgdGhlIHNhbWUgaXNzc3VlIHdpdGggc3ViamVjdA0KPiAiW1BBVENIIDAv
Ml0gZml4IG1lbW9yeSBsZWFrIC8gcGFuaWMgaW4gaW9yZW1hcCBodWdlIHBhZ2VzIi4NCj4gSSd2
ZSB0YWtlbiBzbGlnaHRseSBkaWZmZXJlbnQgYXBwcm9hY2ggaGVyZSwgc28gc2VuZGluZw0KPiB0
byB0aGUgbGlzdCwgZmluYWxseS4NCg0KSGkgQ2hpbnRhbiwNCg0KRG8geW91IGhhdmUgYW55IGlz
c3VlIGluIG15IHBhdGNoc2V0PyAgSWYgc28sIGNhbiB5b3UgcGxlYXNlIGNvbW1lbnQgb24NCnRo
ZW0/ICBJdCBjb21wbGljYXRlcyB0aGUgdGhpbmcgd2hlbiB5b3Ugc2VuZCBhIGRpZmZlcmVudCBh
cHByb2FjaA0Kd2l0aG91dCB0ZWxsaW5nIHdoeSBhIGRpZmZlcmVudCBhcHByb2FjaCBpcyBuZWVk
ZWQuICBZb3VyIGFwcHJvYWNoDQpwdXJnZXMgVExCIGFmdGVyIHVwZGF0aW5nIHBtZC9wdWQsIHdo
aWNoIEkgdGhpbmsgaXMgYnJva2VuLiAgQ2FuIHlvdQ0Kd29yayBvbiB0b3Agb2YgbXkgcGF0Y2hz
ZXQgYW5kIHByb3Blcmx5IGltcGxlbWVudCBwWGRfZnJlZV9wdGVfcGFnZSgpDQpmb3IgYXJtNjQ/
ICBJIHdpbGwgc2VuZCBvdXQgbXkgdjIgdG9kYXkuDQogIA0KVGhhbmtzLA0KLVRvc2hpDQo=
