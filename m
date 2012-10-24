From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 3/3] xtensa: switch to generic sys_execve()
Date: Wed, 24 Oct 2012 13:16:39 +0400
Message-ID: <CAMo8Bf+fkUTDPHh-sbVJj=8SOjMDfpywa=g1sMRFXWfpBhsDYA@mail.gmail.com>
References: <1351043317-21631-1-git-send-email-jcmvbkbc@gmail.com>
	<1351043317-21631-4-git-send-email-jcmvbkbc@gmail.com>
	<20121024024123.GD2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63320 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab2JXJQk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Oct 2012 05:16:40 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so231899oag.19
        for <linux-arch@vger.kernel.org>; Wed, 24 Oct 2012 02:16:39 -0700 (PDT)
In-Reply-To: <20121024024123.GD2616@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Marc Gauthier <marc@tensilica.com>

On Wed, Oct 24, 2012 at 6:41 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Oct 24, 2012 at 05:48:37AM +0400, Max Filippov wrote:
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>>  arch/xtensa/include/asm/syscall.h     |    2 +-
>>  arch/xtensa/include/asm/unistd.h      |    1 +
>>  arch/xtensa/include/uapi/asm/unistd.h |    2 +-
>>  arch/xtensa/kernel/process.c          |   25 -------------------------
>>  4 files changed, 3 insertions(+), 27 deletions(-)
>
> All three applied, but there's a couple of things I'd like to have on top
> of that.  Are you OK with the following incremental?

Yes. Looks like I need to send v2 to address Chris' comments,
I can put these changes there as well.

>         1) ->{set,clear}_child_tid is set by the caller; no need to set it
> in copy_thread().
>         2) for later work it would be easier if copy_thread() hadn't looked
> at regs argument at all; telling kernel_thread(9) from clone(2) can be done
> by checking p->flags & PF_KTHREAD and for clone(2) it's always going to get
> current_pt_regs().
>         3) interpretation of zero newsp is probably better off in copy_thread()
> as well.  Eventually we are going to kill regs argument of do_fork() et.al.
>
> diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
> index 58e50ff..9d8f387 100644
> --- a/arch/xtensa/kernel/process.c
> +++ b/arch/xtensa/kernel/process.c
> @@ -200,7 +200,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>
>  int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
>                 unsigned long thread_fn_arg,
> -                struct task_struct * p, struct pt_regs * regs)
> +                struct task_struct * p, struct pt_regs *unused)
>  {
>         struct pt_regs *childregs = task_pt_regs(p);
>
> @@ -212,10 +212,10 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
>         *((int*)childregs - 3) = (unsigned long)childregs;
>         *((int*)childregs - 4) = 0;
>
> -       p->set_child_tid = p->clear_child_tid = NULL;
>         p->thread.sp = (unsigned long)childregs;
>
> -       if (regs) {
> +       if (!(p->flags & PF_KTHREAD)) {
> +               struct pt_regs *regs = current_pt_regs();
>                 p->thread.ra = MAKE_RA_FOR_CALL(
>                                 (unsigned long)ret_from_fork, 0x1);
>
> @@ -224,7 +224,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
>                  * ARs beyond a0-a15 exist past the end of the struct.
>                  */
>                 *childregs = *regs;
> -               childregs->areg[1] = usp_thread_fn;
> +               if (usp_thread_fn)
> +                       childregs->areg[1] = usp_thread_fn;
>                 childregs->areg[2] = 0;
>
>                 if (clone_flags & CLONE_VM) {
> @@ -346,7 +347,5 @@ long xtensa_clone(unsigned long clone_flags, unsigned long newsp,
>                    void __user *child_tid, long a5,
>                    struct pt_regs *regs)
>  {
> -        if (!newsp)
> -                newsp = regs->areg[1];
>          return do_fork(clone_flags, newsp, regs, 0, parent_tid, child_tid);
>  }



-- 
Thanks.
-- Max
