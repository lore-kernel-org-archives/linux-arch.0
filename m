From: hejianet <hejianet@gmail.com>
Subject: Re: [PATCH v2 2/3] lib: Introduce 2 bit ops api:
 all_is_bit_{one,zero}
Date: Thu, 19 Nov 2015 16:55:03 +0800
Message-ID: <564D8E67.6030706@gmail.com>
References: <1447915724-29709-1-git-send-email-hejianet@gmail.com>
 <1447915724-29709-3-git-send-email-hejianet@gmail.com>
 <564D8B14.9030509@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:32853 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbbKSIzO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 03:55:14 -0500
In-Reply-To: <564D8B14.9030509@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: xinhui <xinhui@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>

Thanks=EF=BC=8C I will add it in next verison
B.R.
Justin

=E5=9C=A8 11/19/15 4:40 PM, xinhui =E5=86=99=E9=81=93:
> hi, jia
>     Nice patch. But I have one minor question. see inline comments.
>
> On 2015/11/19 14:48, Jia He wrote:
>> This patch introduces 2 lightweight bit api.
>> all_bit_is_zero return 1 if the bit string is all zero.
>> The addr is the start address, the size is the bit size of the bit=20
>> string.
>> all_bit_is_one is the opposite.
>>
>> Signed-off-by: Jia He <hejianet@gmail.com>
>> ---
>>   lib/find_bit.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/lib/find_bit.c b/lib/find_bit.c
>> index 18072ea..1d56d8d 100644
>> --- a/lib/find_bit.c
>> +++ b/lib/find_bit.c
>> @@ -131,6 +131,56 @@ unsigned long find_last_bit(const unsigned long=
=20
>> *addr, unsigned long size)
>>   EXPORT_SYMBOL(find_last_bit);
>>   #endif
>>
>> +#ifndef all_bit_is_zero
>> +/*
>> + * return val: 1 means all bit is zero
>> + */
>> +unsigned int all_bit_is_zero(const unsigned long *addr, unsigned si=
ze)
>> +{
>  Seems better that size should be type of "unsigned long". Otherwise=20
> I'm afraid when we compare idx * BITS_PER_LONG with size, there might=
=20
> be overflow issue.
>
>> +    unsigned long idx;
>> +    unsigned long mask =3D size;
>> +
>> +    if (unlikely(size =3D=3D 0))
>> +        return 1;
>> +
>> +    if (size > BITS_PER_LONG) {
>> +        for (idx =3D 0; idx * BITS_PER_LONG < size; idx++)
>> +            if (addr[idx])
>> +                return 0;
>> +
>> +        mask =3D size - (idx - 1) * BITS_PER_LONG;
>> +    }
>> +
>> +    return !(*addr & BITMAP_LAST_WORD_MASK(mask));
>> +}
>> +EXPORT_SYMBOL(all_bit_is_zero);
>> +#endif
>> +
>> +#ifndef all_bit_is_one
>> +/*
>> + * return val: 1 means all bit is one
>> + */
>> +unsigned int all_bit_is_one(const unsigned long *addr, unsigned siz=
e)
>> +{
> this argc of size should be type of "unsigned long", too.
>
> thanks
> xinhui
>
>> +    unsigned long idx;
>> +    unsigned long mask =3D size;
>> +
>> +    if (unlikely(size =3D=3D 0))
>> +        return 1;
>> +
>> +    if (size > BITS_PER_LONG) {
>> +        for (idx =3D 0; idx * BITS_PER_LONG < size; idx++)
>> +            if (~addr[idx])
>> +                return 0;
>> +
>> +        mask =3D size - (idx - 1) * BITS_PER_LONG;
>> +    }
>> +
>> +    return !(~(*addr) & BITMAP_LAST_WORD_MASK(mask));
>> +}
>> +EXPORT_SYMBOL(all_bit_is_one);
>> +#endif
>> +
>>   #ifdef __BIG_ENDIAN
>>
>>   /* include/linux/byteorder does not support "unsigned long" type *=
/
>>
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
