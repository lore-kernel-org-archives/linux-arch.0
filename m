From: Nick Piggin <npiggin@gmail.com>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Mon, 20 Dec 2010 02:46:07 +1100
Message-ID: <AANLkTikwUEBd1Ez75pQ7gw7ShZitwQOQcH6CvCdJV2np@mail.gmail.com>
References: <20101218225436.28264.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34512 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271Ab0LSPqK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Dec 2010 10:46:10 -0500
In-Reply-To: <20101218225436.28264.qmail@science.horizon.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: George Spelvin <linux@horizon.com>
Cc: bharrosh@panasas.com, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Dec 19, 2010 at 9:54 AM, George Spelvin <linux@horizon.com> wro=
te:
>> static inline int dentry_memcmp_long(const unsigned char *cs,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const un=
signed char *ct, ssize_t count)
>> {
>> =A0 =A0 =A0 int ret;
>> =A0 =A0 =A0 const unsigned long *ls =3D (const unsigned long *)cs;
>> =A0 =A0 =A0 const unsigned long *lt =3D (const unsigned long *)ct;
>>
>> =A0 =A0 =A0 while (count > 8) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D (*cs !=3D *ct);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ct++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 count-=3D8;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 if (count) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long t =3D *ct & ((0xffffffffff=
ffffff >> ((8 - count) * 8))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D (*cs !=3D t)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return ret;
>> }
>
> First, let's get the code right, and use correct types, but also, the=
re

You still used the wrong vars in the loop.

> are some tricks to reduce the masking cost.
>
> As long as you have to mask one string, *and* don't have to worry abo=
ut
> running off the end of mapped memory, there's no additional cost to
> masking both in the loop. =A0Just test (a ^ b) & mask.

Using a lookup table I considered, but maybe not well enough. It is
another cacheline, but common to all lookups. So it could well be
worth it, let's keep your code around...

The big problem for CPUs that don't do well on this type of code is
what the string goes through during the entire syscall.

=46irst, a byte-by-byte strcpy_from_user of the whole name string to
kernel space. Then a byte-by-byte chunking and hashing component
paths according to '/'. Then a byte-by-byte memcmp against the
dentry name.

I'd love to do everything with 8 byte loads, do the component
separation and hashing at the same time as copy from user, and
have the padded and aligned component strings and their hash
available... but complexity.

On my Westmere system, time to do a stat is 640 cycles plus=A010
cycles for every byte in the string (this cost holds perfectly
from=A01 byte name up to 32 byte names in my test range).
`git diff` average path name strings are 31 bytes, although this
is much less cache friendly, and over several components (my
test is just a single component).

But still, even if the base cost were doubled, it may still
spend 20% or so kernel cycles in name string handling.

This 8 byte memcpy takes my microbenchmark down to 8=A0cycles per
byte, so it may get several more % on git diff.

A careful thinking about the initial strcpy_from_user, and
hashing code could shave another few cycles off it. Well
worth investigating I think.
