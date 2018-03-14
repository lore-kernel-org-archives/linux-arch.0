From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
Date: Wed, 14 Mar 2018 19:15:11 +0000
Message-ID: <1521054910.11552.44.camel@synopsys.com>
References: <1519917189.13866.6.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519917189.13866.6.camel@synopsys.com>
Content-Language: en-US
Content-ID: <30A2D9E66292534496C2D08722D7A51C@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

UGluZyENCg0KT24gVGh1LCAyMDE4LTAzLTAxIGF0IDE4OjEzICswMzAwLCBBbGV4ZXkgQnJvZGtp
biB3cm90ZToNCj4gSGkgVmluZWV0LA0KPiANCj4gSnVzdCBub3RpY2VkIHRoYXQgaW4gY29tbWVu
dHMgZm9yIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoKSBpdCBpcyBzYWlkIHRoYXQNCj4gcHJlZW1w
dGlvbiBtdXN0IGJlIGRpc2FibGVkIGR1cmluZyBpdHMgZXhlY3V0aW9uLiBBbmQgdGhhdCBmdW5j
dGlvbiBnZXRzIGV4ZWN1dGVkDQo+IGFtb25nIG90aGVyIHdheXMgbGlrZSB0aGF0Og0KPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBmbHVz
aF90bGJfcmFuZ2UoKQ0KPiAgICAgLT4gb25fZWFjaF9jcHVfbWFzaygpDQo+ICAgICAgICAgIC0+
IHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoKQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEknbSBub3Qgc2VlaW5nIHJpZ2h0IG5vdyBh
bnkgcmVhbCBwcm9ibGVtIHdpdGggY3VycmVudCBpbXBsZW1lbnRhdGlvbiBidXQNCj4gc29tZSBh
cmNoaXRlY3R1cmVzIGRvIHRoYXQgdGh1cyB0aGUgcXVlc3Rpb24uDQo+IA0KPiAtQWxleGV5
