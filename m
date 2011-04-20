From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/3] bitops: add ifdef CONFIG_GENERIC_FIND_BIT_LE guard
Date: Thu, 21 Apr 2011 07:59:30 +0900
Message-ID: <BANLkTimBF312svk0mRkt5_Y=t+B12cLW+Q@mail.gmail.com>
References: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
	<201104201631.40017.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60744 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab1DTW7b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2011 18:59:31 -0400
In-Reply-To: <201104201631.40017.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

2011/4/20 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 20 April 2011, Akinobu Mita wrote:
>> index 946a21b..bd2253e 100644
>> --- a/include/asm-generic/bitops/le.h
>> +++ b/include/asm-generic/bitops/le.h
>> @@ -30,6 +30,8 @@ static inline unsigned long find_first_zero_bit_le=
(const void *addr,
>>
>> =A0#define BITOP_LE_SWIZZLE =A0 =A0 =A0 ((BITS_PER_LONG-1) & ~0x7)
>>
>> +#ifdef CONFIG_GENERIC_FIND_BIT_LE
>> +
>> =A0extern unsigned long find_next_zero_bit_le(const void *addr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size, unsigned long of=
fset);
>> =A0extern unsigned long find_next_bit_le(const void *addr,
>> @@ -38,6 +40,8 @@ extern unsigned long find_next_bit_le(const void *=
addr,
>> =A0#define find_first_zero_bit_le(addr, size) \
>> =A0 =A0 =A0 =A0 find_next_zero_bit_le((addr), (size), 0)
>>
>> +#endif /* CONFIG_GENERIC_FIND_BIT_LE */
>> +
>> =A0#else
>> =A0#error "Please fix <asm/byteorder.h>"
>> =A0#endif
>
> The style that we normally use in asm-generic is to test the macro it=
self
> for existence, so in asm-generic, do:
>
> #ifndef find_next_zero_bit_le
> extern unsigned long find_next_zero_bit_le(const void *addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size, unsigned long off=
set);
> #endif
>
> and in the architectures, write
>
> static inline unsigned long find_next_zero_bit_le(const void *addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size, unsigned long off=
set)
> #define find_next_zero_bit_le find_next_zero_bit_le
>
> I guess we can do the #ifdef separately for each of the three macros,
> or choose one of them to use as a key.

I see.

Should we also kill CONFIG_GENERIC_FIND_BIT_LE option comletely,
then add the #ifdef for each find_*() in lib/find_next_bit.c and always=
 build
it unconditionally ?
