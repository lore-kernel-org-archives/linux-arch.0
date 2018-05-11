Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50454 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeEKMob (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2018 08:44:31 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 03/20] arc: use generic dma_noncoherent_ops
Date: Fri, 11 May 2018 12:44:23 +0000
Message-ID: <1526042662.19036.31.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
         <20180511075945.16548-4-hch@lst.de>
In-Reply-To: <20180511075945.16548-4-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <971F7A34D96DA94FBA9D4F8C88AF4970@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "hch@lst.de" <hch@lst.de>
Cc: "deanbo422@gmail.com" <deanbo422@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Message-ID: <20180511124423.9iGzy9T0NG40JYZQX47aDThaHNSd-DQ2SsOsVSZpVRk@z>

SGkgQ2hyaXN0b3BoLA0KDQpPbiBGcmksIDIwMTgtMDUtMTEgYXQgMDk6NTkgKzAyMDAsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOg0KPiBTd2l0Y2ggdG8gdGhlIGdlbmVyaWMgbm9uY29oZXJlbnQg
ZGlyZWN0IG1hcHBpbmcgaW1wbGVtZW50YXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICBhcmNoL2FyYy9LY29uZmlnICAg
ICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL0tidWlsZCAg
ICAgICAgfCAgIDEgKw0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCB8ICAy
MSAtLS0tLQ0KPiAgYXJjaC9hcmMvbW0vZG1hLmMgICAgICAgICAgICAgICAgICB8IDE0MSArKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCAxNDggZGVsZXRpb25zKC0pDQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9hcmMv
aW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaA0KDQpTb3JyeSBJIGRpZG4ndCB0cnkgeW91ciBwcm9w
b3NlZCBmaXggZWFybGllciAtIHdhcyBhd2F5IGZvciBhIGNvdXBsZSBvZiBkYXlzLg0KDQpCdXQg
dGhhdCBuZXdlciB2ZXJzaW9uIHdpdGggZml4ZWQgbGliL2RtYS1ub25jb2hlcmVudC5jIHN0aWxs
IGRvZXNuJ3Qgd29yayBvbiBBUkMuDQoNClVTQiBFQ0hJIGNvbnRyb2xsZXIgZmFpbHMgbGlrZSB0
aGF0Og0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KdXNiIDEtMTogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyBlaGNp
LXBsYXRmb3JtDQp1c2IgMS0xOiBjYW4ndCBzZXQgY29uZmlnICMxLCBlcnJvciAtMzINCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQWdhaW4g
d2l0aCBlbnRpcmUgc2VyaWVzIHJldmVydGVkIFVTQiBzdGFydHMgdG8gd29yay4NCkxldCdzIHdh
aXQgZm9yIG90aGVyIGFyY2hlcyBwcmV2aW91c2x5IGFmZmVjdGVkIHRvIHVwZGF0ZSBvbiB0aGVp
ciBzdGF0dXMuDQoNCi1BbGV4ZXk=
