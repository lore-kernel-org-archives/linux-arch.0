Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:34072 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeG3MIp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jul 2018 08:08:45 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH 3/4] ARC: refactor arch/arc/mm/dma.c
Date: Mon, 30 Jul 2018 10:34:20 +0000
Message-ID: <1532946859.3059.8.camel@synopsys.com>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
         <20180724101001.31965-4-Eugeniy.Paltsev@synopsys.com>
         <20180726091731.GC24209@lst.de>
In-Reply-To: <20180726091731.GC24209@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAD9DEFCFE16EA4C980E8F3C30C8875F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "hch@lst.de" <hch@lst.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180730103420.YtxfzkIVoEzV1hemVne6N0oSr1vbECvCUk83UzFVcmw@z>

T24gVGh1LCAyMDE4LTA3LTI2IGF0IDExOjE3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBKdWwgMjQsIDIwMTggYXQgMDE6MTA6MDBQTSArMDMwMCwgRXVnZW5peSBQ
YWx0c2V2IHdyb3RlOg0KPiA+IFJlZmFjdG9yaW5nLCBubyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRl
bmRlZC4NCj4gPiAgDQpbc25pcF0NCj4gPiAgDQo+ID4gIAkqZG1hX2hhbmRsZSA9IHBhZGRyOw0K
PiA+ICANCj4gPiArCS8qDQo+ID4gKwkgKiAtIEEgY29oZXJlbnQgYnVmZmVyIG5lZWRzIE1NVSBt
YXBwaW5nIHRvIGVuZm9yY2Ugbm9uLWNhY2hhYmlsaXR5DQo+ID4gKwkgKiAtIEEgaGlnaG1lbSBw
YWdlIG5lZWRzIGEgdmlydHVhbCBoYW5kbGUgKGhlbmNlIE1NVSBtYXBwaW5nKQ0KPiA+ICsJICog
ICBpbmRlcGVuZGVudCBvZiBjYWNoYWJpbGl0eS4NCj4gPiArCSAqIGt2YWRkciBpcyBrZXJuZWwg
VmlydHVhbCBhZGRyZXNzICgweDcwMDBfMDAwMCBiYXNlZCkNCj4gPiArCSAqLw0KPiA+ICsJaWYg
KFBhZ2VIaWdoTWVtKHBhZ2UpIHx8IG5lZWRfY29oKSB7DQo+IA0KPiBkbWFfYWxsb2NfYXR0cnMg
Y2xlYXJzIF9fR0ZQX0hJR0hNRU0gZnJvbSB0aGUgcGFzc2VkIGluIGdmcCBtYXNrLCBzbw0KPiB5
b3UnbGwgbmV2ZXIgZ2V0IGEgaGlnaG1lbSBwYWdlIGhlcmUuDQo+IA0KDQpOaWNlIGNhdGNoLCB0
aGFua3MuDQpXaWxsIHJlbW92ZSBjaGVjayBmb3IgaGlnaG1lbSBwYWdlIGluIG5leHQgcGF0Y2gg
dmVyc2lvbi4gDQoNCj4gVGhhdCBhbHNvIG1lYW5zIHlvdSBjYW4gbWVyZ2UgdGhpcyBjb25kaXRp
b25hbCB3aXRoIHRoZSBvbmUgZm9yIHRoZSBjYWNoZQ0KPiB3cml0ZWJhY2sgYW5kIGludmFsaWRh
dGlvbiBhbmQga2lsbCB0aGUgbmVlZF9jb2ggZmxhZyBlbnRpcmVseS4NCj4gDQo+ID4gIAkJa3Zh
ZGRyID0gaW9yZW1hcF9ub2NhY2hlKHBhZGRyLCBzaXplKTsNCj4gPiAgCQlpZiAoa3ZhZGRyID09
IE5VTEwpIHsNCj4gPiAgCQkJX19mcmVlX3BhZ2VzKHBhZ2UsIG9yZGVyKTsNCj4gPiBAQCAtODEs
MTEgKzc1LDkgQEAgdm9pZCBhcmNoX2RtYV9mcmVlKHN0cnVjdCBkZXZpY2UgKmRldiwgc2l6ZV90
IHNpemUsIHZvaWQgKnZhZGRyLA0KPiA+ICB7DQo+ID4gIAlwaHlzX2FkZHJfdCBwYWRkciA9IGRt
YV9oYW5kbGU7DQo+ID4gIAlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZpcnRfdG9fcGFnZShwYWRkcik7
DQo+ID4gLQlpbnQgaXNfbm9uX2NvaCA9IDE7DQo+ID4gLQ0KPiA+IC0JaXNfbm9uX2NvaCA9IChh
dHRycyAmIERNQV9BVFRSX05PTl9DT05TSVNURU5UKTsNCj4gPiArCWJvb2wgaXNfY29oID0gIShh
dHRycyAmIERNQV9BVFRSX05PTl9DT05TSVNURU5UKTsNCj4gPiAgDQo+ID4gLQlpZiAoUGFnZUhp
Z2hNZW0ocGFnZSkgfHwgIWlzX25vbl9jb2gpDQo+ID4gKwlpZiAoUGFnZUhpZ2hNZW0ocGFnZSkg
fHwgaXNfY29oKQ0KPiA+ICAJCWlvdW5tYXAoKHZvaWQgX19mb3JjZSBfX2lvbWVtICopdmFkZHIp
Ow0KPiA+ICANCj4gDQo+IFNhbWUgaGVyZS4NCj4gDQo+IEFsc28gaWYgeW91IGNsZWFuIHRoaXMg
dXAgaXQgd291bGQgYmUgZ3JlYXQgdG8gdGFrZSB0aGUgcGVyLWRldmljZSBwZm4gb2Zmc2V0DQo+
IGludG8gYWNjb3VudCwgZXZlbiBpZiB0aGF0IGlzbid0IHVzZWQgYW55d2hlcmUgb24gYXJjIHll
dCwgdGhhdCBpcyBjYWxsDQo+IHBoeXNfdG9fZG1hIGFuZCBkbWFfdG9fcGh5cyB0byBjb252ZXJ0
IHRvIGFuIGZyb20gdGhlIGRtYSBhZGRyZXNzLg0KDQpPaywgSSdsbCBsb29rIGF0IGl0Lg0KUHJv
YmFibHkgSSdsbCBpbXBsZW1lbnQgaXQgYXMgYSBzZXBhcmF0ZSBwYXRjaCBhcyBpdCBpcyBpcnJl
bGV2YW50IHRvIHRoaXMNCnBhdGNoIHNlcmllcyB0b3BpYy4NCg0KLS0gDQogRXVnZW5peSBQYWx0
c2V2
