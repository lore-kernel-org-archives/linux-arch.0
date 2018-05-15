From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH REPOST 4/5] powerpc: Use update_thread_flag()
Date: Tue, 15 May 2018 13:13:00 +1000
Message-ID: <87d0xxpq6b.fsf@concordia.ellerman.id.au>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com> <1526051104-15995-5-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526051104-15995-5-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Dave Martin <Dave.Martin@arm.com> writes:

> This patch uses the new update_thread_flag() helper to simplify a
> couple of if () set; else clear; constructs.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/elf.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index 548d9a4..136c9b1 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -88,14 +88,8 @@ typedef elf_vrregset_t elf_fpxregset_t;
>  #ifdef __powerpc64__
>  # define SET_PERSONALITY(ex)					\
>  do {								\
> -	if (((ex).e_flags & 0x3) == 2)				\
> -		set_thread_flag(TIF_ELF2ABI);			\
> -	else							\
> -		clear_thread_flag(TIF_ELF2ABI);			\
> -	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
> -		set_thread_flag(TIF_32BIT);			\
> -	else							\
> -		clear_thread_flag(TIF_32BIT);			\
> +	update_thread_flag(TIF_ELF2ABI, ((ex).e_flags & 0x3) == 2);	\
> +	update_thread_flag(TIF_32BIT, (ex).e_ident[EI_CLASS] == ELFCLASS32); \
>  	if (personality(current->personality) != PER_LINUX32)	\
>  		set_personality(PER_LINUX |			\
>  			(current->personality & (~PER_MASK)));	\

Thanks for cleaning it up.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
