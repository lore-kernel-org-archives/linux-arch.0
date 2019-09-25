Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr1310101.outbound.protection.outlook.com ([40.107.131.101]:37171
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728876AbfIYXf3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Sep 2019 19:35:29 -0400
From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Date: Wed, 25 Sep 2019 23:35:18 +0000
Message-ID: <PU1P153MB0169A28B05A7CDE04A57AA58BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-4-git-send-email-decui@microsoft.com>
 <8ba5e2fd-6a9f-b61b-685e-23a69cabe3a2@linaro.org>
In-Reply-To: <8ba5e2fd-6a9f-b61b-685e-23a69cabe3a2@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190925233518.zMrJYGwl0C1gqHtsrwUfLlpRWWr9u3SsVAm8H-XcqWo@z>

PiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjUsIDIwMTkgNDoyMSBQTQ0KPiBUbzogRGV4dWFuIEN1
aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47IGFybmRAYXJuZGIuZGU7IGJwQGFsaWVuOC5kZTsNCj4g
SGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IGhwYUB6eXRvci5jb207IEtZ
IFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29tPjsgbGludXgtaHlwZXJ2QHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWluZ29AcmVkaGF0LmNv
bTsgc2FzaGFsQGtlcm5lbC5vcmc7IFN0ZXBoZW4NCj4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNy
b3NvZnQuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOyB4ODZAa2VybmVsLm9yZzsNCj4gTWljaGFl
bCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+OyBTYXNoYSBMZXZpbg0KPiA8QWxleGFu
ZGVyLkxldmluQG1pY3Jvc29mdC5jb20+DQo+IENjOiBsaW51eC1hcmNoQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvM10gY2xvY2tzb3VyY2UvZHJpdmVyczogU3Vz
cGVuZC9yZXN1bWUgSHlwZXItVg0KPiBjbG9ja3NvdXJjZSBmb3IgaGliZXJuYXRpb24NCj4gDQo+
IE9uIDA2LzA5LzIwMTkgMDA6NDcsIERleHVhbiBDdWkgd3JvdGU6DQo+ID4gVGhpcyBpcyBuZWVk
ZWQgZm9yIGhpYmVybmF0aW9uLCBlLmcuIHdoZW4gd2UgcmVzdW1lIHRoZSBvbGQga2VybmVsLCB3
ZSBuZWVkDQo+ID4gdG8gZGlzYWJsZSB0aGUgImN1cnJlbnQiIGtlcm5lbCdzIFRTQyBwYWdlIGFu
ZCB0aGVuIHJlc3VtZSB0aGUgb2xkIGtlcm5lbCdzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTWljaGFl
bCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+IA0KPiBJIGNhbiB0YWtlIHRoaXMg
cGF0Y2ggaWYgbmVlZGVkLg0KDQpUaGFua3MsIERhbmllbCEgVXN1YWxseSB0Z2x4IHRha2VzIGNh
cmUgb2YgdGhlIHBhdGNoZXMsIGJ1dCBpdCBsb29rcyByZWNlbnRseSBoZQ0KbWF5IGJlIHRvbyBi
dXN5IHRvIGhhbmRsZSB0aGUgMyBwYXRjaGVzLiANCg0KSSBndWVzcyB5b3UgY2FuIHRha2UgdGhl
IHBhdGNoLCBpZiB0Z2x4IGhhcyBubyBvYmplY3Rpb24uIDotKQ0KSWYgeW91IHRha2UgdGhlIHBh
dGNoLCBwbGVhc2UgdGFrZSBhbGwgdGhlIDMgcGF0Y2hlcy4NCg0KVGhhbmtzLA0KLS0gRGV4dWFu
DQo=
