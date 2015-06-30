From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: cleaning per architecture MM hook header files
Date: Tue, 30 Jun 2015 10:43:05 +0200
Message-ID: <55925699.5090600@linux.vnet.ibm.com>
References: <1435587909-23163-1-git-send-email-ldufour@linux.vnet.ibm.com> <55924508.9080101@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:42164 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbF3InL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2015 04:43:11 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
	Tue, 30 Jun 2015 09:43:08 +0100
In-Reply-To: <55924508.9080101@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On 30/06/2015 09:28, Vineet Gupta wrote:
>> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
>> index 769b312c1abb..2febe6ff32ed 100644
>> --- a/arch/arc/include/asm/Kbuild
>> +++ b/arch/arc/include/asm/Kbuild
>> @@ -49,3 +49,4 @@ generic-y += ucontext.h
>>  generic-y += user.h
>>  generic-y += vga.h
>>  generic-y += xor.h
>> +generic-y += mm-arch-hooks.h
>> diff --git a/arch/arc/include/asm/mm-arch-hooks.h b/arch/arc/include/asm/mm-arch-hooks.h
>> deleted file mode 100644
>> index c37541c5f8ba..000000000000
>> --- a/arch/arc/include/asm/mm-arch-hooks.h
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -/*
>> - * Architecture specific mm hooks
>> - *
>> - * Copyright (C) 2015, IBM Corporation
>> - * Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - */
>> -
>> -#ifndef _ASM_ARC_MM_ARCH_HOOKS_H
>> -#define _ASM_ARC_MM_ARCH_HOOKS_H
>> -
>> -#endif /* _ASM_ARC_MM_ARCH_HOOKS_H */
>> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
>> index 83c50193626c..870a2f7cbada 100644
>> --- a/arch/arm/include/asm/Kbuild
>> +++ b/arch/arm/include/asm/Kbuild
>> @@ -36,3 +36,4 @@ generic-y += termios.h
>>  generic-y += timex.h
>>  generic-y += trace_clock.h
>>  generic-y += unaligned.h
>> +generic-y += mm-arch-hooks.h
> 
> We keep this file sorted by headers so please can u respin with right ordering !

Sure, I will send a new version.

Thanks for the review,
Laurent.
