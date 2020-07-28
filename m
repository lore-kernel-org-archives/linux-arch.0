From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 01/24] asm-generic: add generic versions of mmu context
 functions
Date: Tue, 28 Jul 2020 04:01:24 +0000
Message-ID: <12ac3789-71a5-2756-6a9e-769302c7b3c6@synopsys.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-2-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48386 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgG1EBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 00:01:30 -0400
In-Reply-To: <20200728033405.78469-2-npiggin@gmail.com>
Content-Language: en-US
Content-ID: <6B282E90BF3D1C4B9CB1389407D1C8EE@namprd12.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>

T24gNy8yNy8yMCA4OjMzIFBNLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6DQo+IE1hbnkgb2YgdGhl
c2UgYXJlIG5vLW9wcyBvbiBtYW55IGFyY2hpdGVjdHVyZXMsIHNvIGV4dGVuZCBtbXVfY29udGV4
dC5oDQo+IHRvIGNvdmVyIE1NVSBhbmQgTk9NTVUsIGFuZCBzcGxpdCB0aGUgTk9NTVUgYml0cyBv
dXQgdG8gbm9tbXVfY29udGV4dC5oDQo+IA0KDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgc3dpdGNo
X21tKHN0cnVjdCBtbV9zdHJ1Y3QgKnByZXYsDQo+IC0JCQlzdHJ1Y3QgbW1fc3RydWN0ICpuZXh0
LA0KPiAtCQkJc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQo+ICsvKioNCj4gKyAqIGFjdGl2YXRl
X21tIC0gY2FsbGVkIGFmdGVyIGV4ZWMgc3dpdGNoZXMgdGhlIGN1cnJlbnQgdGFzayB0byBhIG5l
dyBtbSwgdG8gc3dpdGNoIHRvIGl0DQo+ICsgKiBAcHJldl9tbTogcHJldmlvdXMgbW0gb2YgdGhp
cyB0YXNrDQo+ICsgKiBAbmV4dF9tbTogbmV3IG1tDQo+ICsgKi8NCj4gKyNpZm5kZWYgYWN0aXZh
dGVfbW0NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhY3RpdmF0ZV9tbShzdHJ1Y3QgbW1fc3RydWN0
ICpwcmV2X21tLA0KPiArCQkJICAgICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm5leHRfbW0pDQo+ICB7
DQo+ICsJc3dpdGNoX21tKHByZXZfbW0sIG5leHRfbW0sIGN1cnJlbnQpOw0KPiAgfQ0KPiArI2Vu
ZGlmDQoNCklzIGFjdGl2YXRlX21tKCkgcmVhbGx5IG5lZWRlZCBub3cuIEl0IHNlZW1zIG1vc3Qg
YXJjaGVzIGhhdmUNCiAgIGFjdGl2YXRlX21tKHAsIG4pIC0+IHN3aXRjaF9tbShwLCBuLCBOVUxM
KQ0KDQpBbmQgaWYgd2UgYXJlIHBhc3NpbmcgY3VycmVudCwgdGhhdCBjYW4gYmUgcHVzaGVkIGlu
c2lkZSBzd2l0Y2hfbW0oKQ0KDQo+ICANCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBhY3RpdmF0ZV9t
bShzdHJ1Y3QgbW1fc3RydWN0ICpwcmV2X21tLA0KPiAtCQkJICAgICAgIHN0cnVjdCBtbV9zdHJ1
Y3QgKm5leHRfbW0pDQo=
