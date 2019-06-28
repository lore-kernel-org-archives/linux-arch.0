Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:55340 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbfF1W7j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jun 2019 18:59:39 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Date: Fri, 28 Jun 2019 22:59:33 +0000
Message-ID: <7ef18a49-cc5a-6cd1-bed3-beec003a73c3@synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <31BEBB84CB2C8E47993409B6B497028A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Jason Baron <jbaron@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190628225933.yPB2H68kkQlP-IuPjKhj8XTJGl_JuPJ2uuMXZqc4LBI@z>

T24gNi8xOC8xOSA5OjE2IEFNLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+IE9uIDYvMTQvMTkgOTo0
MSBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPj4gSW1wbGVtZW50IGp1bXAgbGFiZWwgcGF0
Y2hpbmcgZm9yIEFSQy4gSnVtcCBsYWJlbHMgcHJvdmlkZQ0KPj4gYW4gaW50ZXJmYWNlIHRvIGdl
bmVyYXRlIGR5bmFtaWMgYnJhbmNoZXMgdXNpbmcNCj4+IHNlbGYtbW9kaWZ5aW5nIGNvZGUuDQo+
Pg0KPj4gVGhpcyBhbGxvd3MgdXMgdG8gaW1wbGVtZW50IGNvbmRpdGlvbmFsIGJyYW5jaGVzIHdo
ZXJlDQo+PiBjaGFuZ2luZyBicmFuY2ggZGlyZWN0aW9uIGlzIGV4cGVuc2l2ZSBidXQgYnJhbmNo
IHNlbGVjdGlvbg0KPj4gaXMgYmFzaWNhbGx5ICdmcmVlJw0KPj4NCj4+IFRoaXMgaW1wbGVtZW50
YXRpb24gdXNlcyAzMi1iaXQgTk9QIGFuZCBCUkFOQ0ggaW5zdHJ1Y3Rpb25zDQo+PiB3aGljaCBm
b3JjZWQgdG8gYmUgYWxpZ25lZCBieSA0IHRvIGd1YXJhbnRlZSB0aGF0IHRoZXkgZG9uJ3QNCj4+
IGNyb3NzIEwxIGNhY2hlIGxpbmUgYW5kIGNhbiBiZSB1cGRhdGUgYXRvbWljYWxseS4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5
cy5jb20+DQo+IA0KPiBMR1RNIG92ZXJhbGwgLSBuaXRzIGJlbG93Lg0KDQpAUGV0ZXIgY2FuIHdl
IGhhdmUgeW91ciByZXZpZXdlZC9hY2sgb3Igc29tZSBzdWNoIGFzc3VtaW5nIHlvdSBkb24ndCBo
YXZlIGFueQ0Kb2JqZWN0aW9ucyAhDQoNClRoeCwNCi1WaW5lZXQNCg==
