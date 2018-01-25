From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 6/8] kprobes/arm64: Fix %p uses in error messages
Date: Thu, 25 Jan 2018 16:42:31 +0000
Message-ID: <20180125164230.GC22963@arm.com>
References: <151685799071.3099.10383062804474021403.stgit@devbox>
 <151685817205.3099.18079175391687728067.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37742 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbeAYQmc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jan 2018 11:42:32 -0500
Content-Disposition: inline
In-Reply-To: <151685817205.3099.18079175391687728067.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, catalin.marinas@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jan 25, 2018 at 02:29:32PM +0900, Masami Hiramatsu wrote:
> Fix %p uses in error messages by removing it because
> those are redundant or meaningless.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm64/kernel/probes/kprobes.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

I guess Catalin can just pick this one up via arm64.

Will

> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index d849d9804011..34f78d07a068 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -275,7 +275,7 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
>  		break;
>  	case KPROBE_HIT_SS:
>  	case KPROBE_REENTER:
> -		pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
> +		pr_warn("Unrecoverable kprobe detected.\n");
>  		dump_kprobe(p);
>  		BUG();
>  		break;
> @@ -521,7 +521,7 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>  		    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
>  		pr_err("current sp %lx does not match saved sp %lx\n",
>  		       orig_sp, stack_addr);
> -		pr_err("Saved registers for jprobe %p\n", jp);
> +		pr_err("Saved registers for jprobe\n");
>  		__show_regs(saved_regs);
>  		pr_err("Current registers\n");
>  		__show_regs(regs);
> 
