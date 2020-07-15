From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Wed, 15 Jul 2020 12:08:00 +0200
Message-ID: <87zh816qgv.fsf@igel.home>
References: <20200715094829.252208-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39274 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGOKIF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 06:08:05 -0400
In-Reply-To: <20200715094829.252208-1-npiggin@gmail.com> (Nicholas Piggin's
        message of "Wed, 15 Jul 2020 19:48:29 +1000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-arch@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>

On Jul 15 2020, Nicholas Piggin wrote:

> diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
> index 54a98ef7d7fe..071d7ccb830f 100644
> --- a/arch/powerpc/include/asm/exception-64e.h
> +++ b/arch/powerpc/include/asm/exception-64e.h
> @@ -204,7 +204,11 @@ exc_##label##_book3e:
>  	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
>  	ori	r3,r3,vector_offset@l;		\
>  	mtspr	SPRN_IVOR##vector_number,r3;
> -
> +/*
> + * powerpc relies on return from interrupt/syscall being context synchronising
> + * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without additional
> + * additional synchronisation instructions.

s/additonal//

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
