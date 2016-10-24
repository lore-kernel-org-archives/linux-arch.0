From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/3] THREAD_INFO_IN_TASK prep work for arm64+s390
Date: Mon, 24 Oct 2016 11:12:43 +0100
Message-ID: <20161024101242.GC15620@leverpostej>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com, hpa@zytor.com, keescook@chromium.org, luto@kernel.org, mingo@redhat.com, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

Hi Andrew,

On Wed, Oct 19, 2016 at 07:28:10PM +0100, Mark Rutland wrote:
> Heiko and I have been working on THREAD_INFO_IN_TASK for s390 and arm64
> respectively, and we're both targetting v4.10.
> 
> These are the common core changes which we both require, which happen to
> touch x86 and some core headers. We'd either need these merged for
> v4.9-rc*, or placed on a stable branch/tag that we can both base atop
> of.
> 
> I've put together a branch [1,2] based on v4.9-rc1, but the patches themselves
> are sorely lacking in relevant acks. Are people willing to help change that? ;)

Would you be happy to ack patches 2 and 3?

Ingo took patch 1 for 4.9-rc2, and these are the only core parts s390
and arm64 need to implement THREAD_INFO_IN_TASK for v4.10.

I'd like to put them on a stable branch.

Thanks,
Mark.

> [1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git core/ti-stack-split
> [2] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=core/ti-stack-split
> 
> Heiko Carstens (1):
>   sched/core,x86: make struct thread_info arch specific again
> 
> Mark Rutland (2):
>   thread_info: factor out restart_block
>   thread_info: include <current.h> for THREAD_INFO_IN_TASK
> 
>  arch/x86/include/asm/thread_info.h |  9 +++++++
>  include/linux/restart_block.h      | 51 ++++++++++++++++++++++++++++++++++++
>  include/linux/thread_info.h        | 53 ++------------------------------------
>  3 files changed, 62 insertions(+), 51 deletions(-)
>  create mode 100644 include/linux/restart_block.h
> 
> -- 
> 1.9.1
> 
