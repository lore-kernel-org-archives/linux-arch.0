Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr780054.outbound.protection.outlook.com ([40.107.78.54]:35840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfFUShz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 14:37:55 -0400
From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Date: Fri, 21 Jun 2019 18:37:52 +0000
Message-ID: <D25EC873-572E-457C-AEB1-DC0C1FAF8E85@vmware.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620070120.GU3402@hirez.programming.kicks-ass.net>
 <a0a1aa81-d46e-71db-ff7b-207bc468068d@synopsys.com>
 <20190620212256.GC3436@hirez.programming.kicks-ass.net>
 <20190621120923.GT3463@hirez.programming.kicks-ass.net>
 <20190621121259.GU3463@hirez.programming.kicks-ass.net>
In-Reply-To: <20190621121259.GU3463@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <081FCB91BD58C248919E7BE5CBB9E2A6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Jason Baron <jbaron@akamai.com>, Paolo Bonzini <pbonzini@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190621183752.ZAEK211r92h0cABbk-gAlyNd-uT2BfN3fxQyb5Xw7BE@z>

PiBPbiBKdW4gMjEsIDIwMTksIGF0IDU6MTIgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEp1biAyMSwgMjAxOSBhdCAwMjowOToy
M1BNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gDQo+PiAtLS0gL2Rldi9udWxsDQo+
PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9qdW1wX2xhYmVsX2FzbS5oDQo+PiBAQCAtMCww
ICsxLDQ0IEBADQo+PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4+
ICsjaWZuZGVmIF9BU01fWDg2X0pVTVBfTEFCRUxfQVNNX0gNCj4+ICsjZGVmaW5lIF9BU01fWDg2
X0pVTVBfTEFCRUxfQVNNX0gNCj4+ICsNCj4+ICsjaW5jbHVkZSA8YXNtL2FzbS5oPg0KPj4gKyNp
bmNsdWRlIDxhc20vbm9wcy5oPg0KPj4gKw0KPj4gKyNpZmRlZiBfX0FTU0VNQkxZX18NCj4+ICsN
Cj4+ICsubWFjcm8gU1RBVElDX0JSQU5DSF9FTlRSWSBsX3RhcmdldDpyZXEgbF95ZXM6cmVxIGtl
eTpyZXEgYnJhbmNoOnJlcQ0KPj4gKwkucHVzaHNlY3Rpb24gX19qdW1wX3RhYmxlLCAiYXciDQo+
PiArCS5sb25nCQlcbF90YXJnZXQgLSAuLCBcbF95ZXMgLSAuDQo+PiArI2lmZGVmIF9fWDg2XzY0
X18NCj4+ICsJLnF1YWQJCShca2V5IC0gLikgKyBcYnJhbmNoDQo+PiArI2Vsc2UNCj4+ICsJLmxv
bmcJCShca2V5IC0gLikgKyBcYnJhbmNoDQo+PiArI2VuZGlmDQo+PiArCS5wb3BzZWN0aW9uDQo+
PiArLmVuZG0NCj4+ICsNCj4+ICsubWFjcm8gU1RBVElDX0JSQU5DSF9OT1AgbF95ZXM6cmVxIGtl
eTpyZXEgYnJhbmNoOnJlcQ0KPj4gKy5Mc3RhdGljX2JyYW5jaF9ub3BfXEA6DQo+PiArLmlmbHQg
MTI3IC0gLg0KPiANCj4gVGhhdCBzaG91bGQndmUgYmVlbjoNCj4gDQo+IC5pZiBcbF95ZXMgLSAu
IDwgMTI3DQo+IA0KPiB0b28sIEkgaGFkIGJlZW4gcGxheWluZyB3aXRoIHZhcmlvdXMgZm9ybXMg
dG8gc2VlIHdoZW4gaXQgY29tcGlsZXMuDQo+IEJ1dCBhcyBzb29uIGFzIGEgbGFiZWwgKGVpdGhl
ciBcbF95ZXMgb3IgJy4nIGdldHMgdXNlZCkgaXQgYmFyZnMuDQoNCkkgdGhpbmsgdGhlIGVycm9y
IG1ha2VzIHNlbnNlIGFzIGl0IGNyZWF0ZXMgYSDigJxjaXJjdWxhciBkZXBlbmRlbmN54oCdOg0K
YXNzZW1ibHkgb2YgdGhlIGNvZGUgbWlnaHQgYWZmZWN0IHRoZSBsYWJlbCBhZGRyZXNzLCBhbmQg
dGhpcyBhZGRyZXNzIGFmZmVjdA0KdGhlIGFzc2VtYmx5Lg0KDQo=
