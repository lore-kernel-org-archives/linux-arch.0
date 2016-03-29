From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Tue, 29 Mar 2016 10:27:36 +0800
Message-ID: <56F9E818.1050508@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F3A77D.6060802@redhat.com> <56F75490.9010608@gmail.com>
 <20160328065106.GA12154@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33867 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbcC2C1n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2016 22:27:43 -0400
In-Reply-To: <20160328065106.GA12154@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

=E5=9C=A8 2016=E5=B9=B403=E6=9C=8828=E6=97=A5 14:51, Sam Ravnborg =E5=86=
=99=E9=81=93:
>> diff --git a/include/asm-generic/bitops/arch_parity.h b/include/asm-=
generic/bitops/arch_parity.h
>> new file mode 100644
>> index 0000000..cddc555
>> --- /dev/null
>> +++ b/include/asm-generic/bitops/arch_parity.h
>> @@ -0,0 +1,39 @@
>> +#ifndef _ASM_GENERIC_BITOPS_ARCH_PARITY_H_
>> +#define _ASM_GENERIC_BITOPS_ARCH_PARITY_H_
>> +
>> +#include <asm/types.h>
>> +
>> +/*
>> + * Refrence to 'https://graphics.stanford.edu/~seander/bithacks.htm=
l#ParityParallel'.
>> + */
>> +
>> +static inline unsigned int __arch_parity4(unsigned int w)
>> +{
>> +	w &=3D 0xf;
>> +	return (0x6996 >> w) & 1;
>> +}
>> +
>> +static inline unsigned int __arch_parity8(unsigned int w)
>> +{
>> +	w ^=3D w >> 4;
>> +	return __arch_parity4(w);
>> +}
>> +
>> +static inline unsigned int __arch_parity16(unsigned int w)
>> +{
>> +	w ^=3D w >> 8;
>> +	return __arch_parity8(w);
>> +}
>> +
>> +static inline unsigned int __arch_parity32(unsigned int w)
>> +{
>> +	w ^=3D w >> 16;
>> +	return __arch_parity16(w);
>> +}
>> +
>> +static inline unsigned int __arch_parity64(__u64 w)
>> +{
>> +	return __arch_parity32((unsigned int)(w >> 32) ^ (unsigned int)w);
>> +}
> Defining these as static inlines in asm-generic prevent an architectu=
re
> from selecting between a more optimal asm version or the generic vers=
ion
> at run-time.
> sparc would benefit from this as only some sparc chips supports popc.
> See how this is done for hweight*
>
> 	Sam

Thanks. I will try.
