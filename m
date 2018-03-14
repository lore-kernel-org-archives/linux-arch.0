Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42155 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNUi5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 16:38:57 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: arc_usr_cmpxchg and preemption
Date: Wed, 14 Mar 2018 20:38:53 +0000
Message-ID: <1521059931.11552.51.camel@synopsys.com>
References: <1521045375.11552.27.camel@synopsys.com>
         <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
         <20180314175352.GP4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180314175352.GP4064@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E18847B7F7A53446ACF7F7C86D6A353F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180314203853.2dIKTupiRCtey3oZrk4MJE_Ug0IwpjwvDW_0jL4Mf6M@z>

SGkgUGV0ZXIsIFZpbmVldCwNCg0KT24gV2VkLCAyMDE4LTAzLTE0IGF0IDE4OjUzICswMTAwLCBQ
ZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gV2VkLCBNYXIgMTQsIDIwMTggYXQgMDk6NTg6MTlB
TSAtMDcwMCwgVmluZWV0IEd1cHRhIHdyb3RlOg0KPiANCj4gPiBXZWxsIGl0IGlzIGJyb2tlbiB3
cnQgdGhlIHNlbWFudGljcyB0aGUgc3lzY2FsbCBpcyBzdXBwb3NlZCB0byBwcm92aWRlLg0KPiA+
IFByZWVtcHRpb24gZGlzYWJsaW5nIGlzIHdoYXQgcHJldmVudHMgYSBjb25jdXJyZW50IHRocmVh
ZCBmcm9tIGNvbWluZyBpbiBhbmQNCj4gPiBtb2RpZnlpbmcgdGhlIHNhbWUgbG9jYXRpb24gKElt
YWdpbmUgYSB2YXJpYWJsZSB3aGljaCBpcyBiZWluZyBjbXB4Y2hnDQo+ID4gY29uY3VycmVudGx5
IGJ5IDIgdGhyZWFkcykuDQo+ID4gDQo+ID4gT25lIGFwcHJvYWNoIGlzIHRvIGRvIGl0IHRoZSBN
SVBTIHdheSwgZW11bGF0ZSB0aGUgbGxzYyBmbGFnIC0gc2V0IGl0IHVuZGVyDQo+ID4gcHJlZW1w
dGlvbiBkaXNhYmxlZCBzZWN0aW9uIGFuZCBjbGVhciBpdCBpbiBzd2l0Y2hfdG8NCj4gDQo+ICpz
aHVkZGVyKi4uLiBqdXN0IGNhdGNoIHRoZSAtRUZBVUxULCBmb3JjZSB0aGUgd3JpdGUgZmF1bHQg
YW5kIHJldHJ5Lg0KPiANCj4gU29tZXRoaW5nIGxpa2U6DQo+IA0KPiBpbnQgc3lzX2NtcHhjaGco
dTMyIF9fdXNlciAqdXNlcl9wdHIsIHUzMiBvbGQsIHUzMiBuZXcpDQo+IHsNCj4gCXUzMiB2YWw7
DQo+IAlpbnQgcmV0Ow0KPiANCj4gYWdhaW46DQo+IAlyZXQgPSAwOw0KPiANCj4gCXByZWVtcHRf
ZGlzYWJsZSgpOw0KPiAJdmFsID0gZ2V0X3VzZXIodXNlcl9wdHIpOw0KPiAJaWYgKHZhbCA9PSBv
bGQpDQo+IAkJcmV0ID0gcHV0X3VzZXIobmV3LCB1c2VyX3B0cik7DQo+IAlwcmVlbXB0X2VuYWJs
ZSgpOw0KPiANCj4gCWlmIChyZXQgPT0gLUVGQVVMVCkgew0KPiAJCXN0cnVjdCBwYWdlICpwYWdl
Ow0KPiAJCXJldCA9IGdldF91c2VyX3BhZ2VzX2Zhc3QoKHVuc2lnbmVkIGxvbmcpdXNlcl9wdHIs
IDEsIDEsICZwYWdlKTsNCj4gCQlpZiAocmV0IDwgMCkNCj4gCQkJcmV0dXJuIHJldDsNCj4gCQlw
dXRfcGFnZShwYWdlKTsNCj4gCQlnb3RvIGFnYWluOw0KDQpJIGd1ZXNzIHRoaXMganVtcCB3ZSBu
ZWVkIHRvIGRvIG9ubHkgb25jZSwgcmlnaHQ/DQpJZiBmb3Igd2hhdGV2ZXIgcmVhc29uIGdldF91
c2VyX3BhZ2VzX2Zhc3QoKSBmYWlscyB3ZSByZXR1cm4gaW1tZWRpYXRlbHkNCmFuZCBpZiBpdCBz
dWNjZWVkcyB0aGVyZSdzIG5vIHJlYXNvbiBmb3IgcHV0X3VzZXIoKSB0byBub3Qgc3VjY2VlZCBh
cw0KcmVxdWlyZWQgcGFnZSBpcyBzdXBwb3NlZCB0byBiZSBwcmVwYXJlZCBmb3Igd3JpdGUuDQoN
Ck90aGVyd2lzZSBpZiBzb21ldGhpbmcgZ29lcyB3YXkgdG9vIGJhZCB3ZSBtYXkgZW5kLXVwIGlu
IGFuIGluZmluaXRlIGxvb3ANCndoaWNoIHdlJ2QgYmV0dGVyIHByZXZlbnQuDQoNCj4gCX0NCj4g
DQo+IAlyZXR1cm4gcmV0Ow0KPiB9DQoNCkBWaW5lZXQsIGFyZSB5b3UgT0sgd2l0aCBwcm9wb3Nl
ZCBpbXBsZW1lbnRhdGlvbj8NCg0KLUFsZXhleQ0K
