From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Date: Mon, 27 Jan 2020 12:21:06 +0000
Message-ID: <16f131548042445fb557ecb027d4c2cd@AcuMS.aculab.com>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com>
 <20200124082443.GY14914@hirez.programming.kicks-ass.net>
 <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:40970 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgA0MVL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 07:21:11 -0500
In-Reply-To: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgSmFudWFyeSAyMDIwIDE3OjM3DQouLi4N
Cj4gKFRoYXQgYWxzbyBtZWFucyB0aGF0IHRoZSBjb21waWxlciBjYW4ndCBuZWNlc3NhcmlseSBl
dmVuIG9wdGltaXplDQo+IG11bHRpcGxlIGFjY2Vzc2VzIHRocm91Z2ggYSBjb25zdCBwb2ludGVy
IGF3YXksIGJlY2F1c2UgdGhlIG9iamVjdA0KPiBtaWdodCBiZSBtb2RpZmllZCB0aHJvdWdoIGFu
b3RoZXIgcG9pbnRlciB0aGF0IGFsaWFzZXMgdGhlIGNvbnN0IG9uZSAtDQo+IHlvdSdkIG5lZWQg
dG8gYWxzbyBtYXJrIGl0ICJyZXN0cmljdCIgdG8gdGVsbCB0aGUgY29tcGlsZXIgdGhhdCBubw0K
PiBvdGhlciBwb2ludGVyIHdpbGwgYWxpYXMpLg0KDQpJJ3ZlIHNlZW4gZ2NjIGNhY2hlIGEgdmFs
dWUgcmVhZCB0aHJvdWdoIGEgJ2NvbnN0JyBwYXJhbWV0ZXIgcG9pbnRlcg0KYWNyb3NzIGEgZnVu
Y3Rpb24gY2FsbC4NCkNhbid0IHJlbWVtYmVyIHdoaWNoIHZlcnNpb24gdGhvdWdoLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K
