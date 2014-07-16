Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34420 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658AbaGPHDN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jul 2014 03:03:13 -0400
MIME-Version: 1.0
In-Reply-To: <4999408.jEEY9BVX9F@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-23-git-send-email-lftan@altera.com>
	<4999408.jEEY9BVX9F@wuerfel>
Date: Wed, 16 Jul 2014 15:03:12 +0800
Message-ID: <CAFiDJ58ZPQ0aMrYFv5g-ThgEt4AVFQp0yhCRb+hzJxV2i4Rjyw@mail.gmail.com>
Subject: Re: [PATCH v2 22/29] nios2: Miscellaneous header files
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20140716070312.Pf_s8QK6fBMPpw5r-O5f4Dt9zU7EAu0gi7wZC_md5wo@z>

On Tue, Jul 15, 2014 at 6:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 15 July 2014 16:45:49 Ley Foon Tan wrote:
>> diff --git a/arch/nios2/include/asm/gpio.h b/arch/nios2/include/asm/gpio.h
>> new file mode 100644
>> index 0000000..e726bfc
>> --- /dev/null
>> +++ b/arch/nios2/include/asm/gpio.h

> This seems wrong. If any device drivers rely on this, better fix them to
> use linux/gpio.h directly.
Okay, will remove this file.


>> +#ifndef __ASM_NIOS2_PCI_H__
>> +#define __ASM_NIOS2_PCI_H__
>> +
>> +/* We don't support PCI yet, but some drivers require this file anyway */
>> +
>> +#endif /* __ASM_NIOS2_PCI_H__ */
>
> What's wrong with the generic version?
Change to use generic pci.h.

>
>> +#ifndef _UAPI_ASM_NIOS2_STAT_H
>> +#define _UAPI_ASM_NIOS2_STAT_H
>> +
>> +#include <asm-generic/stat.h>
>> +
>> +#endif
>
> This should just use the Kconfig logic to fall back on the generic file.
Will use generic file.

Regards
Ley Foon
