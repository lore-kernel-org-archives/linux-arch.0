From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] arm64: kasan: clear stale stack poison
Date: Thu, 3 Mar 2016 14:14:29 +0000
Message-ID: <20160303141429.GB19139@leverpostej>
References: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
 <1456928778-22491-4-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37311 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757846AbcCCOOo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 3 Mar 2016 09:14:44 -0500
Content-Disposition: inline
In-Reply-To: <1456928778-22491-4-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, catalin.marinas@arm.com, glider@google.com, mingo@redhat.com, peterz@infradead.org, will.deacon@arm.com

On Wed, Mar 02, 2016 at 02:26:18PM +0000, Mark Rutland wrote:
> Functions which the compiler has instrumented for ASAN place poison on
> the stack shadow upon entry and remove this poison prior to returning.
> 
> In the case of cpuidle, CPUs exit the kernel a number of levels deep
> in C code. Any instrumented functions on this critical path will leave
> portions of the stack shadow poisoned.
> 
> If CPUs lose context and return to the kernel via a cold path, we
> restore a prior context saved in __cpu_suspend_enter are forgotten, and
> we never remove the poison they placed in the stack shadow area by
> functions calls between this and the actual exit of the kernel.
> 
> Thus, (depending on stackframe layout) subsequent calls to instrumented
> functions may hit this stale poison, resulting in (spurious) KASAN
> splats to the console.
> 
> To avoid this, clear any stale poison from the idle thread for a CPU
> prior to bringing a CPU online.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/sleep.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index e33fe33..fd10eb6 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -145,6 +145,10 @@ ENTRY(cpu_resume_mmu)
>  ENDPROC(cpu_resume_mmu)
>  	.popsection
>  cpu_resume_after_mmu:
> +#ifdef CONFIG_KASAN
> +	mov	x0, sp
> +	bl	kasan_unpoison_remaining_stack
> +#endif

Lorenzo, as this was following your suggestion [1], I hope that this
patch looks ok to you?

Are you happy to provide an Ack / Reviewed-by?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/413061.html
