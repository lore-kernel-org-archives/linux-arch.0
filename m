From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Date: Mon, 13 Jan 2020 11:20:50 +0000
Message-ID: <c1c18e9a4f144c6a92a250a206dfef02@AcuMS.aculab.com>
References: <20200110165636.28035-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:45384 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMLU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jan 2020 06:20:56 -0500
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Will Deacon' <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kernel-team@android.com" <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>

RnJvbTogV2lsbCBEZWFjb24NCj4gU2VudDogMTAgSmFudWFyeSAyMDIwIDE2OjU2DQouLi4NCj4g
VGhlIHJvdWdoIHN1bW1hcnkgb2YgdGhlIHNlcmllcyBpczoNCj4gDQo+ICAgKiBEcm9wIHRoZSBH
Q0MgNC44IHdvcmthcm91bmRzLCBzbyB0aGF0IFJFQURfT05DRSgpIGlzIGENCj4gICAgIHN0cmFp
Z2h0Zm9yd2FyZCBkZXJlZmVyZW5jZSBvZiBhIGNhc3QtdG8tdm9sYXRpbGUgcG9pbnRlci4NCg0K
V2hhdCBpcyB0aGUgZWZmZWN0IG9mIHVzaW5nIHRoZSBjaGFuZ2VkIGNvZGUgb24gb2xkZXIgY29t
cGlsZXJzIChlc3AuIHg4Ni02NCk/DQpSZXF1aXJpbmcgZ2NjID4gNC44IGlzIGEgc2lnbmlmaWNh
bnQgYnVtcC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==
