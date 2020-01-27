Return-Path: <SRS0=GP1c=3Q=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:42578 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgA0MEn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 07:04:43 -0500
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Date: Mon, 27 Jan 2020 12:04:37 +0000
Message-ID: <ae9e908f4cfd4908a24a0e542731d31b@AcuMS.aculab.com>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com>
 <20200124082443.GY14914@hirez.programming.kicks-ass.net>
 <CAKwvOdmTOoTXCGN9NaO5_+sqDsK364=oCiVO_D5=btj1GsJrnw@mail.gmail.com>
In-Reply-To: <CAKwvOdmTOoTXCGN9NaO5_+sqDsK364=oCiVO_D5=btj1GsJrnw@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Nick Desaulniers' <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20200127120437.HT78_OahFqUw3roCYztNEE94eilJZ77fBRWpsx0jkpM@z>

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAyNCBKYW51YXJ5IDIwMjAgMTc6MjANCi4u
Lg0KPiA+ID4gR29vZCB0aGluZyBpdCdzIHRoZSB2YXJpYWJsZSBiZWluZyBtb2RpZmllZCB3YXMg
bm90IGRlY2xhcmVkIGNvbnN0OyBJDQo+ID4gPiBnZXQgc3Bvb2tlZCB3aGVuIEkgc2VlIC1XZGlz
Y2FyZGVkLXF1YWxpZmllcnMgYmVjYXVzZSBvZiBTZWN0aW9uDQo+ID4gPiA2LjcuMy42IG9mIHRo
ZSBJU08gQzExIGRyYWZ0IHNwZWM6DQo+ID4gPg0KPiA+ID4gYGBgDQo+ID4gPiBJZiBhbiBhdHRl
bXB0IGlzIG1hZGUgdG8gbW9kaWZ5IGFuIG9iamVjdCBkZWZpbmVkIHdpdGggYSBjb25zdC1xdWFs
aWZpZWQNCj4gPiA+IHR5cGUgdGhyb3VnaCB1c2Ugb2YgYW4gbHZhbHVlIHdpdGggbm9uLWNvbnN0
LXF1YWxpZmllZCB0eXBlLA0KPiA+ID4gdGhlIGJlaGF2aW9yIGlzIHVuZGVmaW5lZC4NCg0KV2Vs
bCBzb21lIG9sZCBzeXN0ZW1zIGhhZCBzbWFsbCBpbnRlZ2VyIGNvbnN0YW50cyBhdCBmaXhlcyBh
ZGRyZXNzZXMuDQpTbyAnY29uc3QgaW50IG9uZSA9IDE7JyAgd291bGQgYmUgYSByZWZlcmVuY2Ug
dG8gdGhlIGdsb2JhbCBjb25zdGFudC4NCkFuIGFzc2lnbm1lbnQgbGlrZSAnKihpbnQgKikmb25l
ID0gMjsnIHdvdWxkIGNoYW5nZSB0aGUgdmFsdWUgb2YgdGhlDQpzeXN0ZW0td2lkZSAnb25lJyBj
b25zdGFudCcuDQoNClByZXR0eSBtdWNoICd1bmRlZmluZWQnLg0KDQpCdXQgbm8gZXhjdXNlIGZv
ciB0aGUgY29tcGlsZXIganVzdCBkaXNjYXJkaW5nIHRoZSBjb2RlLg0KDQpJIHN1c3BlY3QgdGhh
dCB0aGUgY29kZSB0byByZW1vdmUgJ2NvbnN0JyBuZWVkcyB0byAnbGF1bmRlcicgdGhlIHZhbHVl
DQp0aHJvdWdoIGEgc3VpdGFibGUgaW50ZWdlciB0eXBlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K
