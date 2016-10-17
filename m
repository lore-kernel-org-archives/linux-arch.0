From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] thread_info: include <current.h> for THREAD_INFO_IN_TASK
 (WAS: [PATCH 2/3] sched/preempt: include asm/current.h)
Date: Mon, 17 Oct 2016 15:48:13 +0100
Message-ID: <20161017144700.GA11204@leverpostej>
References: <20161014081638.GA4047@osiris>
 <1476441745-10765-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933390AbcJQOsp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Oct 2016 10:48:45 -0400
Content-Disposition: inline
In-Reply-To: <1476441745-10765-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Fri, Oct 14, 2016 at 11:42:25AM +0100, Mark Rutland wrote:
> When CONFIG_THREAD_INFO_IN_TASK is selected, the current_thread_info()
> macro relies on current having been defined prior to its use. However,
> not all users of current_thread_info() include <asm/current.h>, and thus
> current is not guaranteed to be defined.
> 
> When CONFIG_THREAD_INFO_IN_TASK is not selected, it's possible that
> get_current() / current are based upon current_thread_info(), and
> <asm/current.h> includes <asm/thread_info.h>. Thus always including
> <asm/current.h> would result in circular dependences on some platforms.
> 
> To ensure both cases work, this patch includes <asm/current.h>, but only
> when CONFIG_THREAD_INFO_IN_TASK is selected.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  include/linux/thread_info.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> As discussed, it would be great if this could go in along with the patch to
> make thread_info arch-specific again, to make merging the arch-specific parts
> easier (for arm64 and s390).

Urrgh; I've just recalled that this patch alone is insufficient. The
h8300 arch code has an unfixed bug [1], and relies on some implicit
definition ordering that will be broken by this patch.

I have a workaround/cleanup for core code that I'll send with an updated
version of my arm64 series shortly.

Thanks,
Mark.

[1] http://lkml.kernel.org/r/<1476714934-11635-1-git-send-email-mark.rutland@arm.com

> Mark.
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 45f004e..521f84b 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -25,6 +25,7 @@ struct thread_info {
>  #endif
>  
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
> +#include <asm/current.h>
>  #define current_thread_info() ((struct thread_info *)current)
>  #endif
>  
> -- 
> 1.9.1
> 
