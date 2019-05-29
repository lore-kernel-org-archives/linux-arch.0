Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:57053 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfE2Of2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 10:35:28 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190523003916.20726-1-ebiederm@xmission.com>
        <20190523003916.20726-3-ebiederm@xmission.com>
Date: Wed, 29 May 2019 09:35:13 -0500
In-Reply-To: <20190523003916.20726-3-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Wed, 22 May 2019 19:38:52 -0500")
Message-ID: <87muj52use.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [REVIEW][PATCH 02/26] signal/ptrace: Simplify and fix PTRACE_KILL
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190529143513.bi2Y39NWE8jnVO7gA_HVU6WmGz9t4pBlRqCmQhkxpng@z>


I am dropping this one for now, as there are no dependencies with
the other patches, and this probably deserves some discussion on it's
own.

Eric

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Since PTRACE_KILL was introduced in 1.1.78 it has only worked if the
> process is stopped in do_signal.  On a ptraced but non-stopped process
> PTRACE_KILL has always returned success and done nothing.
>
> Separate the noop case of PTRACE_KILL from the case where it does
> nothing.  This fixes the fact that taking sighand lock in
> ptrace_resume is not safe if the process could be in the middle of
> exec or do_exit.  The current test for child->state is insufficient to
> prevent that race.
>
> With the code explicitly implementing the noop people maintaining
> ptrace no longer need to worry what happens in PTRACE_KILL if the
> process is not stopped.
>
> The alternative fix is to change the implementation of PTRACE_KILL
> to just be send_sig(SIGKILL, child, 1);  But I don't know if anything
> depends on the current documented behavior.
>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: b72c186999e6 ("ptrace: fix race between ptrace_resume() and wait_task_stopped()")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/ptrace.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 6f357f4fc859..5d6ff7040863 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -212,15 +212,18 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>   *
>   * Check whether @child is being ptraced by %current and ready for further
>   * ptrace operations.  If @ignore_state is %false, @child also should be in
> - * %TASK_TRACED state and on return the child is guaranteed to be traced
> - * and not executing.  If @ignore_state is %true, @child can be in any
> - * state.
> + * %TASK_TRACED state and on succesful return the child is guaranteed to be
> + * traced and not executing.  If @ignore_state is %true, @child can be in
> + * any state on succesful return.
>   *
>   * CONTEXT:
>   * Grabs and releases tasklist_lock and @child->sighand->siglock.
>   *
>   * RETURNS:
> - * 0 on success, -ESRCH if %child is not ready.
> + * 0 on success,
> + * -ESRCH if %child is not traced
> + * -EAGAIN if %child can not be frozen
> + * -EBUSY if the wait for %child fails
>   */
>  static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  {
> @@ -240,6 +243,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  		 * child->sighand can't be NULL, release_task()
>  		 * does ptrace_unlink() before __exit_signal().
>  		 */
> +		ret = -EAGAIN;
>  		if (ignore_state || ptrace_freeze_traced(child))
>  			ret = 0;
>  	}
> @@ -253,7 +257,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  			 * so we should not worry about leaking __TASK_TRACED.
>  			 */
>  			WARN_ON(child->state == __TASK_TRACED);
> -			ret = -ESRCH;
> +			ret = -EBUSY;
>  		}
>  	}
>  
> @@ -1074,8 +1078,6 @@ int ptrace_request(struct task_struct *child, long request,
>  		return ptrace_resume(child, request, data);
>  
>  	case PTRACE_KILL:
> -		if (child->exit_state)	/* already dead */
> -			return 0;
>  		return ptrace_resume(child, request, SIGKILL);
>  
>  #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
> @@ -1147,14 +1149,17 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
>  		goto out_put_task_struct;
>  	}
>  
> -	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
> -				  request == PTRACE_INTERRUPT);
> -	if (ret < 0)
> -		goto out_put_task_struct;
> -
> -	ret = arch_ptrace(child, request, addr, data);
> -	if (ret || request != PTRACE_DETACH)
> -		ptrace_unfreeze_traced(child);
> +	ret = ptrace_check_attach(child, request == PTRACE_INTERRUPT);
> +	if (!ret) {
> +		ret = arch_ptrace(child, request, addr, data);
> +		if (ret || request != PTRACE_DETACH)
> +			ptrace_unfreeze_traced(child);
> +	}
> +	/* PTRACE_KILL is a noop when not attached */
> +	else if ((request == PTRACE_KILL) && (ret != -ESRCH))
> +		ret = 0;
> +	else
> +		ret = -ESRCH;
>  
>   out_put_task_struct:
>  	put_task_struct(child);
> @@ -1292,13 +1297,17 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
>  		goto out_put_task_struct;
>  	}
>  
> -	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
> -				  request == PTRACE_INTERRUPT);
> +	ret = ptrace_check_attach(child, request == PTRACE_INTERRUPT);
>  	if (!ret) {
>  		ret = compat_arch_ptrace(child, request, addr, data);
>  		if (ret || request != PTRACE_DETACH)
>  			ptrace_unfreeze_traced(child);
>  	}
> +	/* PTRACE_KILL is a noop when not attached */
> +	else if ((request == PTRACE_KILL) && (ret != -ESRCH))
> +		ret = 0;
> +	else
> +		ret = -ESRCH;
>  
>   out_put_task_struct:
>  	put_task_struct(child);
