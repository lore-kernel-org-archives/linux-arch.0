From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] sched/preempt: include asm/current.h
Date: Fri, 14 Oct 2016 00:25:56 +0100
Message-ID: <20161013232556.GA24167@remoulade>
References: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
 <20161013115712.29517-3-heiko.carstens@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753702AbcJMX0E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Oct 2016 19:26:04 -0400
Content-Disposition: inline
In-Reply-To: <20161013115712.29517-3-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

Hi,

On Thu, Oct 13, 2016 at 01:57:11PM +0200, Heiko Carstens wrote:
> The generic preempt code needs to include <asm/current.h>. Otherwise
> compilation fails if THREAD_INFO_IN_TASK is selected and the generic
> preempt code is used:
> 
> ./include/linux/thread_info.h:17:54: error: 'current' undeclared (first use in this function)
>  #define current_thread_info() ((struct thread_info *)current)

I don't think this is the right fix. Users of current_thread_info() should only
have to include <linux/thread_info.h>, as <asm-generic/preempt.h> already does.

I have a patch [1] which has <linux/thread_info.h> include <asm/current.h> the
THREAD_INFO_IN_TASK case (while avoiding circular includes over <asm/current.h>
and <asm/thread_info.h> in the !THREAD_INFO_IN_TASK case).

I was planning on posting an updated series with that come -rc1.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/457243.html

> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  include/asm-generic/preempt.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
> index c1cde3577551..66fcd6cd7fc6 100644
> --- a/include/asm-generic/preempt.h
> +++ b/include/asm-generic/preempt.h
> @@ -2,6 +2,7 @@
>  #define __ASM_PREEMPT_H
>  
>  #include <linux/thread_info.h>
> +#include <asm/current.h>
>  
>  #define PREEMPT_ENABLED	(0)
>  
> -- 
> 2.8.4
> 
