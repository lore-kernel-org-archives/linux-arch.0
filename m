From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] mm: cleaning per architecture MM hook header files
Date: Tue, 30 Jun 2015 12:58:08 +0530
Message-ID: <55924508.9080101@synopsys.com>
References: <1435587909-23163-1-git-send-email-ldufour@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37738 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750992AbbF3H3n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2015 03:29:43 -0400
In-Reply-To: <1435587909-23163-1-git-send-email-ldufour@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Monday 29 June 2015 07:55 PM, Laurent Dufour wrote:
> The commit 2ae416b142b6 ("mm: new mm hook framework") introduced an empty
> header file (mm-arch-hooks.h) for every architecture, even those which
> doesn't need to define mm hooks.
> 
> As suggested by Geert Uytterhoeven, this could be cleaned through the use
> of a generic header file included via each per architecture
> asm/include/Kbuild file.
> 
> The powerpc architecture is not impacted here since this architecture has
> to defined the arch_remap MM hook.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-arch@vger.kernel.org
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> ---

snipped....

> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
> index 769b312c1abb..2febe6ff32ed 100644
> --- a/arch/arc/include/asm/Kbuild
> +++ b/arch/arc/include/asm/Kbuild
> @@ -49,3 +49,4 @@ generic-y += ucontext.h
>  generic-y += user.h
>  generic-y += vga.h
>  generic-y += xor.h
> +generic-y += mm-arch-hooks.h
> diff --git a/arch/arc/include/asm/mm-arch-hooks.h b/arch/arc/include/asm/mm-arch-hooks.h
> deleted file mode 100644
> index c37541c5f8ba..000000000000
> --- a/arch/arc/include/asm/mm-arch-hooks.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/*
> - * Architecture specific mm hooks
> - *
> - * Copyright (C) 2015, IBM Corporation
> - * Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifndef _ASM_ARC_MM_ARCH_HOOKS_H
> -#define _ASM_ARC_MM_ARCH_HOOKS_H
> -
> -#endif /* _ASM_ARC_MM_ARCH_HOOKS_H */
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 83c50193626c..870a2f7cbada 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -36,3 +36,4 @@ generic-y += termios.h
>  generic-y += timex.h
>  generic-y += trace_clock.h
>  generic-y += unaligned.h
> +generic-y += mm-arch-hooks.h

We keep this file sorted by headers so please can u respin with right ordering !

Thx,
-Vineet
