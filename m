From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Thu, 23 Jan 2020 17:07:40 +0000
Message-ID: <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
References: <20200123153341.19947-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:52870 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbgAWRHo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 12:07:44 -0500
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Will Deacon' <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kernel-team@android.com" <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

RnJvbTogV2lsbCBEZWFjb24NCj4gU2VudDogMjMgSmFudWFyeSAyMDIwIDE1OjM0DQouLi4NCj4g
ICAqIE9ubHkgd2FybiBvbmNlIGF0IGJ1aWxkLXRpbWUgaWYgR0NDIHByaW9yIHRvIDQuOCBpcyBk
ZXRlY3RlZC4uLg0KPiANCj4gICAqIC4uLiBhbmQgdGhlbiByYWlzZSB0aGUgbWluaW11bSBHQ0Mg
dmVyc2lvbiB0byA0LjgsIHdpdGggYW4gZXJyb3IgZm9yDQo+ICAgICBvbGRlciB2ZXJzaW9ucyBv
ZiB0aGUgY29tcGlsZXINCg0KSWYgdGhlIGtlcm5lbCBjb21waWxlZCB3aXRoIGdjYyA0LjcgaXMg
bGlrZWx5IHRvIGJlIGJ1Z2d5LCBkb24ndCB0aGVzZQ0KbmVlZCB0byBiZSBpbiB0aGUgb3RoZXIg
b3JkZXI/DQoNCk90aGVyd2lzZSB5b3UgbmVlZCB0byBrZWVwIHRoZSBvbGQgdmVyc2lvbnMgZm9y
IHVzZSB3aXRoIHRoZSBvbGQNCmNvbXBpbGVycy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==
