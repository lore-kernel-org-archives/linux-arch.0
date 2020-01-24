From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Fri, 24 Jan 2020 10:11:03 +0000
Message-ID: <a9d4a3c113ed4f09897477d3a9be1f84@AcuMS.aculab.com>
References: <20200123153341.19947-1-will@kernel.org>
 <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck>
 <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
 <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
 <20200123190125.GA2683468@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52749 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730743AbgAXKLI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 05:11:08 -0500
In-Reply-To: <20200123190125.GA2683468@rani.riverdale.lan>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arvind Sankar' <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kernel-team@android.com" <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>

RnJvbTogQXJ2aW5kIFNhbmthcg0KPiBTZW50OiAyMyBKYW51YXJ5IDIwMjAgMTk6MDENCi4uLg0K
PiA+ID4gT2ggLSBhbmQgSSBuZWVkIHRvIGZpbmQgYSBuZXdlciBjb21waWxlciA6LSgNCj4gPg0K
PiA+IFdoYXQgZGlzdHJvIGFyZSB5b3UgdXNpbmc/IERvZXMgaXQgaGF2ZSBhIHBhY2thZ2UgZm9y
IGEgbmV3ZXINCj4gPiBjb21waWxlcj8gIEknbSBob25lc3RseSBjdXJpb3VzIGFib3V0IHdoYXQg
cG9saWNpZXMgaWYgYW55IHRoZSBrZXJuZWwNCj4gPiBoYXMgZm9yIHN1cHBvcnRpbmcgZGV2ZWxv
cGVyJ3MgdG9vbGNoYWlucyBmcm9tIHRoZWlyIGRpc3RyaWJ1dGlvbnMuDQoNCkxpa2UgbWFueSBk
ZXZlbG9wZXJzIEkgZ2V0IGxhenkgd2l0aCB1cGdyYWRlcyBvZiBzb21lIHN5c3RlbXMuDQpTbyBt
eSBtYWluIExpbnV4ICdkZXNrdG9wJyBzeXN0ZW0gaXMgcnVubmluZyBVYnVudHUgMTMuMDQgdXNl
cnNwYWNlDQp3aXRoIGEgdmVyeSByZWNlbnQga2VybmVsLg0KU28gaXQgaGFzIGdjYyA0LjcuMyBh
cyBkZWZhdWx0IGFuZCBhIGdjYyA0LjguMSBpbnN0YWxsZWQgKHByb2JhYmx5IG5vdCBtYXR1cmUN
CmVub3VnaCB0byBiZSBzYWZlISkuDQooSSd2ZSAyIG90aGVyIGk3IHN5c3RlbXMgcnVubmluZyBV
YnVudHUgMTguMDQuMHggd2l0aCB0aGUgZGlzdHJvIGtlcm5lbHMuKQ0KLi4uDQo+IEkgdGhpbmsg
dGhlIGlzc3VlIGlzIG5vdCBqdXN0IGtlcm5lbCBkZXZzLiBVc2VycyBtYXkgbmVlZCB0byBjb21w
aWxlIGENCj4gY3VzdG9tIGtlcm5lbCBvciBhdCBsZWFzdCBidWlsZCBhIG1vZHVsZS4NCg0KSWYg
dGhleSBhcmUganVzdCBidWlsZGluZyBhIG1vZHVsZSB0aGV5J2xsIGJlIHVzaW5nIHRoZSBrZXJu
ZWwgaGVhZGVycw0KdGhhdCBnbyB3aXRoIHRoZSBkaXN0cm8ga2VybmVsIC0gYW5kIHRoZSBtb2R1
bGUgc291cmNlcyB3aWxsIG5lZWQgdG8NCm1hdGNoLiBTbyB0aGUgZGlzdHJvJ3MgZ2NjIHNob3Vs
ZCBtYXRjaC4NCg0KTXVjaCBtb3JlIGludGVyZXN0aW5nIGlzIHRoZSBnY2MgY29tcGlsZXIgd2Ug
dXNlIHRvIGdlbmVyYXRlIHRoZQ0KJ2JpbmFyeSBibG9iJyBmb3Igb3VyICdvdXQgb2YgdHJlZScg
ZHJpdmVycy4NClRoZXNlIGdldCBjb21waWxlZCAod2l0aG91dCBhbnkgb2YgdGhlIGtlcm5lbCBo
ZWFkZXJzKSBvbiB0aGUNCnNhbWUgc3lzdGVtIGFzIHdlIGJ1aWxkIHRoZSB1c2Vyc3BhY2UgcHJv
Z3JhbXMgb24uDQpUbyBnZXQgbGliYyBhbmQgKGVzcGVjaWFsbHkpIGxpYmMrKyBjb21wYXRpYmls
aXR5IHRoaXMgaGFzIHRvIGJlDQphIHZlcnkgb2xkIHN5c3RlbSAtIGFzIG9sZCBhcyB0aGUgb2xk
ZXN0IHN5c3RlbSBhbnkgb2Ygb3VyDQpjdXN0b21lcnMgYXJlIGxpa2VseSB0byB1c2UuDQpJbiBw
cmFjdGlzZSB0aGlzIChub3cpIG1lYW5zIHNvbWV0aGluZyBydW5uaW5nIGEgMi42LjMyIGVyYQ0K
a2VybmVsIChvciBzbGlnaHRseSBlYXJsaWVyKS4NClNvIGlzIGEgZGViaWFuIGdjYyA0LjMuMi0x
LjEgY29tcGlsZXIuDQpJIHRoaW5rIHdlJ3ZlIGZpbmFsbHkgcGVyc3VhZGVkIGFsbCBvdXIgY3Vz
dG9tZXJzIHRvIHVwZ3JhZGUgZnJvbSAyLjYuMTguDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=
