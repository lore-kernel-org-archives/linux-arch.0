From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Mon, 28 Mar 2016 10:15:24 +0800
Message-ID: <56F893BC.1030100@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F3A77D.6060802@redhat.com> <56F75490.9010608@gmail.com>
 <20160327124401.GA7407@ravnborg.org> <56F7E24F.3040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35286 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbcC1CPa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Mar 2016 22:15:30 -0400
In-Reply-To: <56F7E24F.3040306@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 2016=E5=B9=B403=E6=9C=8827=E6=97=A5 21:38, zhaoxiu.zeng wrote:
> On 2016/3/27 20:44, Sam Ravnborg wrote:
>> Hi Zeng.
>>
>> Looking through the arch specific implementations of __arch_parity()=
=2E
>> Some architectures uses #defines, other uses inline static functions=
=2E
>>
>> Any particular reason that you select one approach over the other
>> in the different cases?
>>
>> ia64:
>> +#define __arch_parity32(x) ((unsigned int) __arch_parity64((x) & 0x=
fffffffful))
>> +#define __arch_parity16(x) ((unsigned int) __arch_parity64((x) & 0x=
fffful))
>> +#define __arch_parity8(x)  ((unsigned int) __arch_parity64((x) & 0x=
fful))
>> +#define __arch_parity4(x)  ((unsigned int) __arch_parity64((x) & 0x=
ful))
>>
>> tile:
>> +static inline unsigned int __arch_parity32(unsigned int w)
>> +{
>> +	return __builtin_popcount(w) & 1;
>> +}
>> +
>> +static inline unsigned int __arch_parity16(unsigned int w)
>> +{
>> +	return __arch_parity32(w & 0xffff);
>> +}
>> +
>> +static inline unsigned int __arch_parity8(unsigned int w)
>> +{
>> +	return __arch_parity32(w & 0xff);
>> +}
>> +
>> +static inline unsigned int __arch_parity4(unsigned int w)
>> +{
>> +	return __arch_parity32(w & 0xf);
>> +}
>>
> No particular reason, just like the architecture's __arch_hweightN.
>
>> Just two examples.
>>
>> Adding the parity helpers seems like veny nice simplifications.
>>
>> A few comments to some of those I looked at.
>> (I am not subscribed to lkml, so you get it as comments here)
>>
> I think the conversion is simple and readable.
>
>> [PATCH 21/31] mtd: use parity16 in ssfdc.c
>> The original code semes to check that the parity equals the
>> value of first bit in the address.
>> This seems lost after the conversion.
>>
> The original get_parity return 1 if the number is even, so
> if block_address is valid, "block_address & 0x7ff" must be odd.
Make corrections:

The original get_parity return 1 if hweight of the input number is even=
, so
if block_address is valid, hweight of "block_address & 0x7ff" must be o=
dd.

>
>> [PATCH 20/31] scsi: use parity32 in isci/phy.c
>> +	if (parity32(phy_cap.all))
>>   		phy_cap.parity =3D 1;
>> Could be written like this - simpler IMO:
>> 	phy_cap.parity =3D parity32(phy_cap.all);
>>
>>
>> 	Sam
>>
> Yes. Thanks!
>
