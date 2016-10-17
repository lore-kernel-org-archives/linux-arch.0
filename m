From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RESEND] h8300: fix syscall restarting
Date: Mon, 17 Oct 2016 10:04:32 -0700
Message-ID: <CALCETrX82Jdu+bqg70S4x-bzXrSW+u1jMbQmpviMdTU=6y2uTA@mail.gmail.com>
References: <1476714934-11635-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34421 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755102AbcJQRE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2016 13:04:56 -0400
Received: by mail-vk0-f46.google.com with SMTP id b186so184559328vkb.1
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2016 10:04:53 -0700 (PDT)
In-Reply-To: <1476714934-11635-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, uclinux-h8-devel@lists.sourceforge.jp

On Mon, Oct 17, 2016 at 7:35 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Back in commit f56141e3e2d9aabf ("all arches, signal: move restart_block
> to struct task_struct"), all architectures and core code were changed to
> use task_struct::restart_block. However, when h8300 support was
> subsequently restored in v4.2, it was not updated to account for this,
> and maintains thread_info::restart_block, which is not kept in sync.
>
> This patch drops the redundant restart_block from thread_info, and moves
> h8300 to the common one in task_struct, ensuring that syscall restarting
> always works as expected.

This is Obviously Correct (tm).  Should it have a cc: stable?

--Andy

>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: linux-arch@vger.kernel.org
> Cc: stable@vger.kernel.org # v4.2+
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> ---
>  arch/h8300/include/asm/thread_info.h | 4 ----
>  arch/h8300/kernel/signal.c           | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> This was previously sent as a reply to another patch [1], and then subsequently
> on its own [2], but I haven't heard anything for about three weeks since the
> last posting.
>
> This happens to get in the way of moving thread_info into task_struct on some
> architectures as it implicitly relies on include ordering in a core header. I
> have a workaround for that, but this does seem like a major bug regardless...
>
> Mark.
>
> [1] http://lkml.kernel.org/r/20160919104254.GA12473@leverpostej
> [2] http://lkml.kernel.org/r/1474918434-3870-1-git-send-email-mark.rutland@arm.com
>
> diff --git a/arch/h8300/include/asm/thread_info.h b/arch/h8300/include/asm/thread_info.h
> index b408fe6..3cef068 100644
> --- a/arch/h8300/include/asm/thread_info.h
> +++ b/arch/h8300/include/asm/thread_info.h
> @@ -31,7 +31,6 @@ struct thread_info {
>         int                cpu;                 /* cpu we're on */
>         int                preempt_count;       /* 0 => preemptable, <0 => BUG */
>         mm_segment_t            addr_limit;
> -       struct restart_block restart_block;
>  };
>
>  /*
> @@ -44,9 +43,6 @@ struct thread_info {
>         .cpu =          0,                      \
>         .preempt_count = INIT_PREEMPT_COUNT,    \
>         .addr_limit     = KERNEL_DS,            \
> -       .restart_block  = {                     \
> -               .fn = do_no_restart_syscall,    \
> -       },                                      \
>  }
>
>  #define init_thread_info       (init_thread_union.thread_info)
> diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
> index ad1f81f..7138303 100644
> --- a/arch/h8300/kernel/signal.c
> +++ b/arch/h8300/kernel/signal.c
> @@ -79,7 +79,7 @@ struct rt_sigframe {
>         unsigned int er0;
>
>         /* Always make any pending restarted system calls return -EINTR */
> -       current_thread_info()->restart_block.fn = do_no_restart_syscall;
> +       current->restart_block.fn = do_no_restart_syscall;
>
>         /* restore passed registers */
>  #define COPY(r)  do { err |= get_user(regs->r, &usc->sc_##r); } while (0)
> --
> 1.9.1
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
