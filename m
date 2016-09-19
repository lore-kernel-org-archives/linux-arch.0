From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Mon, 19 Sep 2016 17:45:52 +1000
Message-ID: <77737e9a-e8d7-0f2d-2303-8fdbaf45b8bb@gmail.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35743 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbcISHpk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2016 03:45:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id 6so3910600pfl.2
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2016 00:45:39 -0700 (PDT)
In-Reply-To: <20160916085736.7857-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org



On 16/09/16 18:57, Nicholas Piggin wrote:
> Implementing busy wait loops with cpu_relax() in callers poses
> some difficulties for powerpc.
> 
> First, we want to put our SMT thread into a low priority mode for the
> duration of the loop, but then return to normal priority after exiting
> the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> cpu_relax() does may have HMT_medium take effect before HMT_low made
> any (or much) difference.
> 
> Second, it can be beneficial for some implementations to spin on the
> exit condition with a statically predicted-not-taken branch (i.e.,
> always predict the loop will exit).
> 

IIUC, what you are proposing is that cpu_relax() be split such 
that on entry we do HMT_low() and on exit do HMT_medium(). I think
that makes a lot of sense, in that it allows the required transition
time from low to medium

> This is a quick RFC with a couple of users converted to see what
> people think. I don't use a C branch with hints, because we don't want
> the compiler moving the loop body out of line, which makes it a bit
> messy unfortunately. If there's a better way to do it, I'm all ears.
> 
> I would not propose to switch all callers immediately, just some
> core synchronisation primitives.
> 
> ---
>  arch/powerpc/include/asm/processor.h | 22 ++++++++++++++++++++++
>  include/asm-generic/barrier.h        |  7 ++-----
>  include/linux/bit_spinlock.h         |  5 ++---
>  include/linux/cgroup.h               |  7 ++-----
>  include/linux/seqlock.h              | 10 ++++------
>  5 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 68e3bf5..e10aee2 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -402,6 +402,28 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
>  
>  #ifdef CONFIG_PPC64
>  #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
> +
> +#define spin_do						\

How about cpu_relax_begin()?

> +do {							\
> +	HMT_low();					\
> +	__asm__ __volatile__ (	"1010:");
> +
> +#define spin_while(cond)				\

cpu_relax_while()
> +	barrier();					\
> +	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
> +				"beq-	1010b	\n\t"	\
> +				: : "r" (cond));	\
> +	HMT_medium();					\
> +} while (0)
> +


> +#define spin_until(cond)				\

This is just spin_while(!cond) from an implementation perspective right?

cpu_relax_until()

> +	barrier();					\
> +	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
> +				"bne-	1010b	\n\t"	\
> +				: : "r" (cond));	\
> +	HMT_medium();					\
> +} while (0)
> +

Then add cpu_relax_end() that does HMT_medium()

Balbir Singh.
