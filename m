From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 03/24] arc: use asm-generic/mmu_context.h for no-op
 implementations
Date: Tue, 28 Jul 2020 03:58:25 +0000
Message-ID: <04b9872c-e9d8-2221-0bf6-595dbd15d8eb@synopsys.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-4-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48292 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgG1D6g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 23:58:36 -0400
In-Reply-To: <20200728033405.78469-4-npiggin@gmail.com>
Content-Language: en-US
Content-ID: <D5326CEBC1A9364D90F83A08A49FA43D@namprd12.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

T24gNy8yNy8yMCA4OjMzIFBNLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6DQoNCj4gIC8qDQo+IC0g
KiBDYWxsZWQgYXQgdGhlIHRpbWUgb2YgZXhlY3ZlKCkgdG8gZ2V0IGEgbmV3IEFTSUQNCj4gLSAq
IE5vdGUgdGhlIHN1YnRsZXR5IGhlcmU6IGdldF9uZXdfbW11X2NvbnRleHQoKSBiZWhhdmVzIGRp
ZmZlcmVudGx5IGhlcmUNCj4gLSAqIHZzLiBpbiBzd2l0Y2hfbW0oKS4gSGVyZSBpdCBhbHdheXMg
cmV0dXJucyBhIG5ldyBBU0lELCBiZWNhdXNlIG1tIGhhcw0KPiAtICogYW4gdW5hbGxvY2F0ZWQg
ImluaXRpYWwiIHZhbHVlLCB3aGlsZSBpbiBsYXR0ZXIsIGl0IG1vdmVzIHRvIGEgbmV3IEFTSUQs
DQo+IC0gKiBvbmx5IGlmIGl0IHdhcyB1bmFsbG9jYXRlZA0KPiArICogYWN0aXZhdGVfbW0gZGVm
YXVsdHMgdG8gc3dpdGNoX21tIGFuZCBpcyBjYWxsZWQgYXQgdGhlIHRpbWUgb2YgZXhlY3ZlKCkg
dG8NCg0KV2l0aCBhY3RpdmF0ZV9tbSgpIGRlZmluaXRpb24gYWN0dWFsbHkgZ29uZSwgcGVyaGFw
cyBhZGQgImFjdGl2YXRlX21tKCkgY29tZXMgZnJvbQ0KZ2VuZXJpYyBjb2RlLi4uIiB0byBwcm92
aWRlIG5leHQgcmVhZGVyIGFib3V0IHRoZSAic3B1cmlvdXMgbG9va2luZyBjb21tZW50Ig0KDQo+
ICsgKiBnZXQgYSBuZXcgQVNJRCBOb3RlIHRoZSBzdWJ0bGV0eSBoZXJlOiBnZXRfbmV3X21tdV9j
b250ZXh0KCkgYmVoYXZlcw0KPiArICogZGlmZmVyZW50bHkgaGVyZSB2cy4gaW4gc3dpdGNoX21t
KCkuIEhlcmUgaXQgYWx3YXlzIHJldHVybnMgYSBuZXcgQVNJRCwNCj4gKyAqIGJlY2F1c2UgbW0g
aGFzIGFuIHVuYWxsb2NhdGVkICJpbml0aWFsIiB2YWx1ZSwgd2hpbGUgaW4gbGF0dGVyLCBpdCBt
b3ZlcyB0bw0KPiArICogYSBuZXcgQVNJRCwgb25seSBpZiBpdCB3YXMgdW5hbGxvY2F0ZWQNCj4g
ICAqLw0KPiAtI2RlZmluZSBhY3RpdmF0ZV9tbShwcmV2LCBuZXh0KQkJc3dpdGNoX21tKHByZXYs
IG5leHQsIE5VTEwpDQo+ICANCj4gIC8qIGl0IHNlZW1lZCB0aGF0IGRlYWN0aXZhdGVfbW0oICkg
aXMgYSByZWFzb25hYmxlIHBsYWNlIHRvIGRvIGJvb2sta2VlcGluZw0KPiAgICogZm9yIHJldGly
aW5nLW1tLiBIb3dldmVyIGRlc3Ryb3lfY29udGV4dCggKSBzdGlsbCBuZWVkcyB0byBkbyB0aGF0
IGJlY2F1c2UNCj4gQEAgLTE2OCw4ICsxNjksNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc3dpdGNo
X21tKHN0cnVjdCBtbV9zdHJ1Y3QgKnByZXYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm5leHQsDQo+ICAg
KiB0aGVyZSBpcyBhIGdvb2QgY2hhbmNlIHRoYXQgdGFzayBnZXRzIHNjaGVkLW91dC9pbiwgbWFr
aW5nIGl0J3MgQVNJRCB2YWxpZA0KPiAgICogYWdhaW4gKHRoaXMgdGVhc2VkIG1lIGZvciBhIHdo
b2xlIGRheSkuDQo+ICAgKi8NCj4gLSNkZWZpbmUgZGVhY3RpdmF0ZV9tbSh0c2ssIG1tKSAgIGRv
IHsgfSB3aGlsZSAoMCkNCg0Kc2FtZSBmb3IgZGVhY3RpdmF0ZV9tbSgpDQo=
