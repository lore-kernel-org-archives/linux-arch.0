From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [RFC PATCH] linker script: unify usage of discard definition
Date: Sat, 4 Jul 2009 01:51:04 -0400
Message-ID: <8bd0f97a0907032251p753527e1oac25ea1740a1bfdb@mail.gmail.com>
References: <4A4E9638.20304@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f202.google.com ([209.85.212.202]:57584 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZGDFvV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jul 2009 01:51:21 -0400
In-Reply-To: <4A4E9638.20304@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Sam Ravnborg <sam@ravnborg.org>, Paul Mundt <lethal@linux-sh.org>, Tony Luck <tony.luck@intel.com>

T24gRnJpLCBKdWwgMywgMjAwOSBhdCAxOTozNywgVGVqdW4gSGVvIHdyb3RlOgo+ICsvKgo+ICsg
KiBESVNDQVJEUyBtdXN0IGJlIHRoZSBsYXN0IGFuZCBhcmNocyB3aGljaCB3YW50IHNvbWUgb2Yg
dGhlIGRlZmF1bHQKPiArICogZGlzY2FyZGVkIHNlY3Rpb25zIGluIHRoZSBrZXJuZWwgaW1hZ2Ug
Y2FuIGRvIHNvIGJ5IHB1dHRpbmcgdGhlbSBpbgo+ICsgKiBlYXJsaWVyIHNlY3Rpb24gZGVmaW5p
dGlvbi4KPiArICovCj4gwqAjZGVmaW5lIERJU0NBUkRTIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFwKPiDCoCDCoCDCoCDCoC9ESVNDQVJELyA6IHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXAo+IMKgIMKg
IMKgIMKgRVhJVF9URVhUIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFwKPiDCoCDCoCDCoCDCoEVY
SVRfREFUQSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcCj4gLSDCoCDCoCDCoCAqKC5leGl0Y2Fs
bC5leGl0KSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcCj4gKyDCoCDCoCDCoCBFWElUX0NBTEwgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXAo+IMKgIMKgIMKgIMKgKiguZGlzY2FyZCkgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgXAo+IMKgIMKgIMKgIMKgfQoKaSB3b3VsZCBhZGQgdG8gdGhlIGNvbW1lbnQgdGhhdCBzb21l
IHBlb3BsZSB3YW50IHRvIGRpc2NhcmQgZXhpdAp0ZXh0L2RhdGEgYXQgcnVudGltZSByYXRoZXIg
dGhhbiBsaW5rIHRpbWUgZHVlIHRvIGNyb3NzLXNlY3Rpb24KcmVmZXJlbmNlcyBzdWNoIGFzIGFs
dCBpbnN0cnVjdGlvbnMsIGJ1ZyB0YWJsZSwgZWhfZnJhbWUsIGV0Yy4uLgoKb3RoZXJ3aXNlLCBs
b29rcyBnb29kIHRvIG1lLiAgdGhhbmtzICEKCkFja2VkLWJ5OiBNaWtlIEZyeXNpbmdlciA8dmFw
aWVyQGdlbnRvby5vcmc+Ci1taWtlCg==
