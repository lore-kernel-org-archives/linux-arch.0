Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:57870 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeERONy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 10:13:54 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
Date: Fri, 18 May 2018 14:13:47 +0000
Message-ID: <913e288c5aabf0224cedcf2eb0c9be309745eace.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
         <20180511075945.16548-3-hch@lst.de>
         <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
         <20180518132731.GA31125@lst.de>
In-Reply-To: <20180518132731.GA31125@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C702843E962C4C4087A6422611F424FA@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "hch@lst.de" <hch@lst.de>
Cc: "deanbo422@gmail.com" <deanbo422@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Message-ID: <20180518141347.cKPK3lRWdAKR_B-ey27eqQd5DQOCO8DDPGTaDc9olp8@z>

SGkgQ2hyaXN0b3BoLA0KDQpPbiBGcmksIDIwMTgtMDUtMTggYXQgMTU6MjcgKzAyMDAsIGhjaEBs
c3QuZGUgd3JvdGU6DQo+IE9uIEZyaSwgTWF5IDE4LCAyMDE4IGF0IDAxOjAzOjQ2UE0gKzAwMDAs
IEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+IE5vdGUgbW1jX2dldF9kbWFfZGlyKCkgaXMganVz
dCAiZGF0YS0+ZmxhZ3MgJiBNTUNfREFUQV9XUklURSA/IERNQV9UT19ERVZJQ0UgOiBETUFfRlJP
TV9ERVZJQ0UiLg0KPiA+IEkuZS4gaWYgd2UncmUgcHJlcGFyaW5nIGZvciBzZW5kaW5nIGRhdGEg
ZG1hX25vbmNvaGVyZW50X21hcF9zZygpIHdpbGwgaGF2ZSBETUFfVE9fREVWSUNFIHdoaWNoDQo+
ID4gaXMgcXVpdGUgT0sgZm9yIHBhc3NpbmcgdG8gZG1hX25vbmNvaGVyZW50X3N5bmNfc2dfZm9y
X2RldmljZSgpIGJ1dCBpbiBjYXNlIG9mIHJlYWRpbmcgd2UnbGwgaGF2ZQ0KPiA+IERNQV9GUk9N
X0RFVklDRSB3aGljaCB3ZSdsbCBwYXNzIHRvIGRtYV9ub25jb2hlcmVudF9zeW5jX3NnX2Zvcl9k
ZXZpY2UoKSBpbiBkbWFfbm9uY29oZXJlbnRfbWFwX3NnKCkuDQo+ID4gDQo+ID4gSSdkIHNheSB0
aGlzIGlzIG5vdCBlbnRpcmVseSBjb3JyZWN0IGJlY2F1c2UgSU1ITyBhcmNoX3N5bmNfZG1hX2Zv
cl9jcHUoKSBpcyBzdXBwb3NlZCB0byBvbmx5IGJlIHVzZWQNCj4gPiBpbiBjYXNlIG9mIERNQV9G
Uk9NX0RFVklDRSBhbmQgYXJjaF9zeW5jX2RtYV9mb3JfZGV2aWNlKCkgb25seSBpbiBjYXNlIG9m
IERNQV9UT19ERVZJQ0UuDQo+IA0KPiBhcmMgb3ZlcnJpZGVzIHRoZSBkaXIgcGFyYW10ZXIgb2Yg
dGhlIGRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlLw0KPiBkbWFfc3luY19zaW5nbGVfZm9yX2Nw
dSBjYWxscy4gIE15IHBhdGNoZXMgZHJvcHBlZCB0aGF0LCBhbmQgSSBoYXZlDQo+IHJlc3RvcmVk
IHRoYXQsIGFuZCBhdWRpdCBmb3IgdGhlIG90aGVyIGFyY2hpdGVjdHVyZXMgaXMgcGVuZGluZy4N
Cg0KV2VsbCBhdCBsZWFzdCBmb3IgbWUgdGhhdCdzIGEgY29uZnVzaW9uIHdoYXQgaXMgYSByZWFz
b24gdG8gcGFzcyBkaXJlY3Rpb24NCnRvIGZ1bmN0aW9uIHdoaWNoIHB1cnBvc2UgaXMgYWxyZWFk
eSBrbm93bi4NCg0KSSdkIHNheSB0aGF0IFhYWF9zeW5jX2Zvcl9kZXZpY2UoKSBkb2Vzbid0IG5l
ZWQgX3ZhcmlhYmxlXyBkaXJlY3Rpb24gYXMgYW4gYXJndW1lbnQsDQpvdGhlcndpc2Ugd2hhdCBk
b2VzIHRoYXQgbWVhbiBpZiB3ZSBwYXNzIERNQV9GUk9NX0RFVklDRSB0byB0aGF0IGZ1bmN0aW9u
Pw0KDQo+IFRoYXQgYmVpbmcgc2FpZCB0aGUgZXhpc3RpbmcgYXJjIGNvZGUgc3RpbGwgbG9va3Mg
cmF0aGVyIG9kZCBhcyBpdA0KPiBkaWRuJ3QgZG8gdGhlIHNhbWUgdGhpbmcgZm9yIHRoZSBzY2F0
dGVybGlzdCB2ZXJzaW9ucyBvZiB0aGUgY2FsbHMuDQoNClRoYXQgbWlnaHQgZWFzaWx5IGJlIHRo
ZSBjYXNlIHNvIGdvb2Qgd2UgY2F1Z2h0IHRoYXQgbm93IGFuZCBpdCB3aWxsIGJlIGZpeGVkIDop
DQoNCj4gSSd2ZSB0aHJvd24gaW4gYSBmZXcgcGF0Y2hlcyBpbnRvIG15IG5ldyB0cmVlIHRvIG1h
a2UgdGhlIHNnIHZlcnNpb25zDQo+IG1ha2UgdGhlIG5vcm1hbCBjYWxscywgYW5kIHRvIGNsZWFu
IHVwIHRoZSBhcmVhIGEgYml0Lg0KDQpJJ2xsIHRyeSB5b3VyIG5ld2VyIHNlcmllcyBub3csIHRo
YW5rcyENCg0KLUFsZXhleQ==
