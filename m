From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 12:00:28 +0000
Message-ID: <138620e379794e98b606ed675da6d04d@AcuMS.aculab.com>
References: <20180106123242.77f4d860@alans-desktop>
 <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp> <20180107063356.GA9425@1wt.eu>
 <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.182]:52549 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756744AbeAHL7x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2018 06:59:53 -0500
In-Reply-To: <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDcgSmFudWFyeSAyMDE4IDE5OjQ3DQouLi4N
Cj4gQWxzbywgcGVvcGxlIGRlZmluaXRlbHkgKmFyZSogbm90aWNpbmcgdGhlIHBlcmZvcm1hbmNl
IGlzc3VlcyB3aXRoIHRoZQ0KPiBjdXJyZW50IHNldCBvZiBwYXRjaGVzLCBhbmQgdGhleSBhcmUg
Y2F1c2luZyByZWFsIHByb2JsZW1zLiBHbyBzZWFyY2gNCj4gZm9yIHJlcG9ydHMgb2YgQW1hem9u
IEFXUyBzbG93ZG93bnMuDQoNClRyeSBvdmVyIDM1JSBzbG93ZG93bi4uLi4NCkdpdmVuIHRoYXQg
QVdTIGluc3RhbmNlIHJ1bnMga25vd24gY29kZSAodXNlciBhbmQga2VybmVsKSB3aHkgZG8gd2UN
Cm5lZWQgdG8gd29ycnkgYWJvdXQgYW55IG9mIHRoZXNlIHNpZGViYW5kIGF0dGFja3M/DQoNCglE
YXZpZA0KDQo=
