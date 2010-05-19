From: Yinghai <yinghai.lu@oracle.com>
Subject: Re: [PATCH] Prevent reserving RAM in the region already reserved
 by BIOS
Date: Wed, 19 May 2010 10:40:38 -0700
Message-ID: <4BF42296.1030905@oracle.com>
References: <AANLkTimwxXtNnmBuDJxg3i72VwWuHmemjrr1iGqj4j8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:28142 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0ESRm0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 May 2010 13:42:26 -0400
In-Reply-To: <AANLkTimwxXtNnmBuDJxg3i72VwWuHmemjrr1iGqj4j8e@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>

On 05/18/2010 10:35 PM, Mathieu Rondonneau wrote:
> Does it make sense to prevent looking for stolen RAM below the ISA section.
> 
> 
> Signed-off-by: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
> ---
>  arch/x86/kernel/e820.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 7bca3c6..322c9c3 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1156,6 +1156,8 @@ void __init e820_reserve_resources_late(void)
>                         end = MAX_RESOURCE_SIZE;
>                 if (start >= end)
>                         continue;
> +               if (end < ISA_START_ADDRESS)
> +                       continue;
>                 printk(KERN_DEBUG "reserve RAM buffer: %016llx - %016llx ",
>                                start, end);
>                 reserve_region_with_split(&iomem_resource, start, end,

do you notice any changes in /proc/iomem?

YH
