From: Alexey Brodkin <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Thu, 4 Oct 2018 16:19:16 +0000
Message-ID: <ad4f865a92828c3226628a0e378ca2fb4054e96a.camel@synopsys.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
         <20180709140717.GR2476@hirez.programming.kicks-ass.net>
         <20180709141056.GR2512@hirez.programming.kicks-ass.net>
         <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
         <20180709144925.GU2476@hirez.programming.kicks-ass.net>
         <4f6e9e8bf60f05872afaed4a1d8e516331e95ea7.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <4f6e9e8bf60f05872afaed4a1d8e516331e95ea7.camel@synopsys.com>
Content-Language: en-US
Content-ID: <A8E53F6133B72C4FAA865926D1CDE440@internal.synopsys.com>
Sender: stable-owner@vger.kernel.org
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "greg@kroah.com" <greg@kroah.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, Vineet Gupta <vineet.gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxNzo1MyArMDMwMCwgQWxleGV5IEJy
b2RraW4gd3JvdGU6DQo+IEhpIFBldGVyLA0KPiANCj4gT24gTW9uLCAyMDE4LTA3LTA5IGF0IDE2
OjQ5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gPiBPbiBNb24sIEp1bCAwOSwgMjAx
OCBhdCAwMjozMzoyNlBNICswMDAwLCBBbGV4ZXkgQnJvZGtpbiB3cm90ZToNCj4gPiA+ID4gSW4g
ZmFjdCwgc2luY2UgYWxsb2NfZHIoKSB1c2VzIGttYWxsb2MoKSB0byBhbGxvY2F0ZSB0aGUgZW50
aXJlIHRoaW5nLA0KPiA+ID4gPiBpdCBpcyBpbXBvc3NpYmxlIHRvIGd1YXJhbnRlZSBhIGxhcmdl
ciBhbGlnbm1lbnQgdGhhbiBrbWFsbG9jIGRvZXMuDQo+ID4gPiANCj4gPiA+IFdlbGwgYnV0IDQt
Ynl0ZXMgW3doaWNoIGlzIGNyaXRpY2FsIGZvciBhdG9taWM2NF90XSBzaG91bGQgYmUgbXVjaCBs
ZXNzDQo+ID4gPiB0aGFuIGEgc2FuZSBjYWNoZSBsaW5lIGxlbmd0aCBzbyBhYm92ZSBzaG91bGQg
d29yay4NCj4gPiANCj4gPiBBRkFJQ1QgQVJDSF9LTUFMTE9DX01JTkFMSUdOIGVuZHMgdXAgYmVp
bmcgNCBvbiB4ODZfMzIgKGl0IGRvZXNuJ3QNCj4gPiBkZWZpbmUgQVJDSF9ETUFfTUlOQUxJR04g
YW5kIGRvZXNuJ3Qgc2VlbSB0byBvdGhlcndpc2Ugb3ZlcnJpZGUgdGhlDQo+ID4gdGhpbmcpLg0K
PiA+IA0KPiA+IFNvIHVuY29uZGl0aW9uYWxseSBzZXR0aW5nIHRoZSBhbGlnbm1lbnQgb2YgZGV2
cmVzOjpkYXRhIHRvIDggc2VlbXMNCj4gPiBicm9rZW4uDQo+IA0KPiBXZWxsIGJ1dCB0aGVuIHdo
YXQgb3RoZXIgb3B0aW9ucyBkbyB3ZSBoYXZlIHRvIGZpeCBhIHByb2JsZW0gd2l0aA0KPiBtaXNh
bGlnbmVkIGFjY2VzcyB0byBhdG9taWM2NF90IGluIGRybV9ncHVfc2NoZWR1bGVyPw0KDQpQaW5n
IQ0KDQpTaG91bGQgSSBzZW5kIHY0IHdpdGggQVJDSF9LTUFMTE9DX01JTkFMSUdOIHVzZWQgZm9y
IGFsaWdubWVudA0KaWYgZXhwbGljaXRseSBzZXQgX19hbGlnbmVkX18oOCkgd2lsbCBicmVhayB4
ODZfMzI/DQoNCi1BbGV4ZXkNCg==
