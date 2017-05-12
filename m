Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.193]:50121 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756286AbdELNUE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2017 09:20:04 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] spin loop primitives for busy waiting
Date: Fri, 12 May 2017 12:58:12 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFE9D65@AcuExch.aculab.com>
References: <20170511165727.17847-1-npiggin@gmail.com>
 <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
In-Reply-To: <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20170512125812.X-XJ-Wsh9jomInHVtrnAp1W5isW5rCBeZjB7WZmHm6Q@z>

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTEgTWF5IDIwMTcgMTk6NDgNCi4uLg0KPiBU
aGUgb25lIHF1ZXN0aW9uIEkgaGF2ZSBpcyBhYm91dCAic3Bpbl9vbl9jb25kKCkiOiBzaW5jZSB5
b3UNCj4gZXhwbGljaXRseSBkb2N1bWVudCB0aGF0IHRoZSAibm8gc3Bpbm5pbmciIGNhc2UgaXMg
ZXhwZWN0ZWQgdG8gYmUgdGhlDQo+IGRlZmF1bHQsIEkgcmVhbGx5IHRoaW5rIHRoYXQgdGhlIGRl
ZmF1bHQgaW1wbGVtZW50YXRpb24gc2hvdWxkIGJlDQo+IGFsb25nIHRoZSBsaW5lcyBpZg0KPiAN
Cj4gICAjZGVmaW5lIHNwaW5fb25fY29uZChjb25kKSBkbyB7IFwNCj4gICAgIGlmICh1bmxpa2Vs
eSghKGNvbmQpKSkgeyBcDQo+ICAgICAgICAgc3Bpbl9iZWdpbigpOyBkbyBzcGluX2NwdV9yZWxh
eCgpOyB3aGlsZSAoIShjb25kKSk7IHNwaW5fZW5kKCk7IFwNCj4gICAgIH0gXA0KPiAgIH0gd2hp
bGUgKDApDQo+IA0KPiB3aGljaCB3aWxsIGFjdHVhbGx5IHJlc3VsdCBpbiBiZXR0ZXIgY29kZSBn
ZW5lcmF0aW9uIGV2ZW4gaWYNCj4gc3Bpbl9iZWdpbi9lbmQoKSBhcmUgbm8tb3BzLCBhbmQganVz
dCBnZW5lcmFsbHkgb3B0aW1pemVzIGZvciB0aGUNCj4gcmlnaHQgYmVoYXZpb3IgKGllIGRvIHRo
ZSBzcGlubmluZyBvdXQtb2YtbGluZSwgc2luY2UgYnkgZGVmaW5pdGlvbiBpdA0KPiBjYW5ub3Qg
YmUgcGVyZm9ybWFuY2UtY3JpdGljYWwgYWZ0ZXIgdGhlIGZpcnN0IGl0ZXJhdGlvbikuDQoNCkF0
IGxlYXN0IHNvbWUgdmVyc2lvbnMgb2YgZ2NjIGNvbnZlcnQgd2hpbGUgKGNvbmQpIGRvIHtib2R5
fQ0KaW50byBpZiAoY29uZCkgZG8ge2JvZHl9IHdoaWxlIChjb25kKSBldmVuIHdoZW4gJ2NvbmQn
DQppcyBhIG5vbi10cml2aWFsIGV4cHJlc3Npb24gYW5kICdib2R5JyBpcyB0cml2aWFsLg0KVGhl
IGNvZGUtYmxvYXQgaXMgc2lsbHkuDQpObyBwb2ludCBlbmZvcmNpbmcgdGhlICdvcHRpbWlzYXRp
b24nIGhlcmUuDQoNCglEYXZpZA0K
