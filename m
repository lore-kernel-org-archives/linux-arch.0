From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Wed, 15 Jul 2020 08:27:15 -0400 (EDT)
Message-ID: <849841781.14062.1594816035327.JavaMail.zimbra@efficios.com>
References: <20200715094829.252208-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:33686 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgGOM1Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 08:27:16 -0400
In-Reply-To: <20200715094829.252208-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arch <linux-arch@vger.kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>

----- On Jul 15, 2020, at 5:48 AM, Nicholas Piggin npiggin@gmail.com wrote:
[...]
> index 47bd4ea0837d..a4704f405e8d 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -68,6 +68,13 @@
>  *
>  * The nop instructions allow us to insert one or more instructions to flush the
>  * L1-D cache when returning to userspace or a guest.
> + *
> + * powerpc relies on return from interrupt/syscall being context synchronising
> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
> + * without additional additional synchronisation instructions. soft-masked
> + * interrupt replay does not include a context-synchronising rfid, but those
> + * always return to kernel, the context sync is only required for IPIs which
> + * return to user.
>  */
> #define RFI_FLUSH_SLOT							\
> 	RFI_FLUSH_FIXUP_SECTION;					\

I suspect the statement "the context sync is only required for IPIs which return to
user." is misleading.

As I recall that we need more than just context sync after IPI. We need context sync
in return path of any trap/interrupt/system call which returns to user-space, else
we'd need to add the proper core serializing barriers in the scheduler, as we had
to do for lazy tlb on x86.

Or am I missing something ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
