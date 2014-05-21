From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 26/27] x86: Use common bits from generic tlb.h
Date: Wed, 21 May 2014 13:57:30 -0700
Message-ID: <537D133A.8020005@zytor.com>
References: <1400093999-18703-1-git-send-email-richard@nod.at> <1400093999-18703-27-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41885 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbaEUU6B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 May 2014 16:58:01 -0400
In-Reply-To: <1400093999-18703-27-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>, linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org

On 05/14/2014 11:59 AM, Richard Weinberger wrote:
> It is no longer needed to define them on our own.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/x86/include/asm/tlb.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> index c779730..f4c76d6 100644
> --- a/arch/x86/include/asm/tlb.h
> +++ b/arch/x86/include/asm/tlb.h
> @@ -1,10 +1,6 @@
>  #ifndef _ASM_X86_TLB_H
>  #define _ASM_X86_TLB_H
>  
> -#define tlb_start_vma(tlb, vma) do { } while (0)
> -#define tlb_end_vma(tlb, vma) do { } while (0)
> -#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
> -
>  #define tlb_flush(tlb)							\
>  {									\
>  	if (!tlb->fullmm && !tlb->need_flush_all) 			\
> 

Quite trivial, obviously.

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
