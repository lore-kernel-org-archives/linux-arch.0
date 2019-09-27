From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Date: Fri, 27 Sep 2019 05:57:31 +0000
Message-ID: <PU1P153MB01693752993D9EFE0DB377DEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-4-git-send-email-decui@microsoft.com>
 <8ba5e2fd-6a9f-b61b-685e-23a69cabe3a2@linaro.org>
 <PU1P153MB0169A28B05A7CDE04A57AA58BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <17e5a535-8597-4780-7cd0-e8c4d2aa8f0f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17e5a535-8597-4780-7cd0-e8c4d2aa8f0f@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

PiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAyNiwgMjAxOSA2OjE3IEFNDQo+ID4+DQo+ID4+IEkgY2Fu
IHRha2UgdGhpcyBwYXRjaCBpZiBuZWVkZWQuDQo+ID4NCj4gPiBUaGFua3MsIERhbmllbCEgVXN1
YWxseSB0Z2x4IHRha2VzIGNhcmUgb2YgdGhlIHBhdGNoZXMsIGJ1dCBpdCBsb29rcyByZWNlbnRs
eSBoZQ0KPiA+IG1heSBiZSB0b28gYnVzeSB0byBoYW5kbGUgdGhlIDMgcGF0Y2hlcy4NCj4gPg0K
PiA+IEkgZ3Vlc3MgeW91IGNhbiB0YWtlIHRoZSBwYXRjaCwgaWYgdGdseCBoYXMgbm8gb2JqZWN0
aW9uLiA6LSkNCj4gPiBJZiB5b3UgdGFrZSB0aGUgcGF0Y2gsIHBsZWFzZSB0YWtlIGFsbCB0aGUg
MyBwYXRjaGVzLg0KPiANCj4gSSBtYWludGFpbiBkcml2ZXJzL2Nsb2Nrc291cmNlIGZvciB0aGUg
dGlwL3RpbWVycy9jb3JlIGJyYW5jaC4gSSBkb24ndA0KPiB3YW50IHRvIHByb3h5IGFub3RoZXIg
dGlwIGJyYW5jaCBhcyBpdCBpcyBvdXQgb2YgbXkganVyaXNkaWN0aW9uLg0KDQpJIHNlZS4gVGhh
bmtzIGZvciB0aGUgZXhwbGFuYXRpb24hIEkgbGVhcm5lZCBtb3JlIGFib3V0IHRoZSB0aXAgdHJl
ZS4gOi0pDQoNCj4gU28gSSBjYW4gdGFrZSBwYXRjaCAzLzMgYnV0IHdpbGwgbGV0IHRoZSBvdGhl
ciAyIHBhdGNoZXMgdG8gYmUgcGlja2VkIGJ5DQo+IHRoZSByaWdodCBwZXJzb24uIEl0IGlzIHlv
dXIgY2FsbC4NCg0KU291bmRzIGdvb2QuIERhbmllbCwgdGhlbiBwbGVhc2UgdGFrZSB0aGlzIHBh
dGNoLCBlLmcuIHBhdGNoIDMvMy4NCg0KUGF0Y2ggMi8zIG1heSBhcyB3ZWxsIGdvIHRocm91Z2gg
U2FzaGEncyBoeXBlci12IHRyZWUsIHNpbmNlIGl0J3MgcmVxdWlyZWQgYnkNCm90aGVyIGNoYW5n
ZXMgdG8gdGhlIGRyaXZlcnMgaHZfYmFsbG9vbiwgaHZfdXRpbHMgYW5kIGh2X3ZtYnVzLg0KDQpJ
IHN1cHBvc2UgdGdseCBpcyB0aGUgYmVzdCBwZXJzb24gdG8gdGFrZSBwYXRjaCAxLzMsIGJ1dCBp
ZiBoZSdzIHRvbyBidXN5IHRvDQpoYW5kbGUgaXQsIGl0IGNhbiBhbHNvIGdvIHRocm91Z2ggdGhl
IGh5cGVyLXYgdHJlZSwgc2luY2UgdGhlIHJlbGF0ZWQgb3RoZXINCnBhdGNoZXMgaGF2ZSBiZWVu
IGluIHRoZSBtYWlubGluZSBub3cuDQoNClRoYW5rcywNCi0tIERleHVhbg0K
