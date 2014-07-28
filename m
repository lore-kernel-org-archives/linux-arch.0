From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
Date: Mon, 28 Jul 2014 19:37:23 +0200
Message-ID: <20140728173723.GA20993@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

Hi Andy,

I am really sorry for delay.

This is on top of the recent change from Kees, right? Could me remind me
where can I found the tree this series based on? So that I could actually
apply these changes...

On 07/21, Andy Lutomirski wrote:
>
> +long syscall_trace_enter_phase2(struct pt_regs *regs, u32 arch,
> +				unsigned long phase1_result)
>  {
>  	long ret = 0;
> +	u32 work = ACCESS_ONCE(current_thread_info()->flags) &
> +		_TIF_WORK_SYSCALL_ENTRY;
> +
> +	BUG_ON(regs != task_pt_regs(current));
>  
>  	user_exit();
>  
> @@ -1458,17 +1562,20 @@ long syscall_trace_enter(struct pt_regs *regs)
>  	 * do_debug() and we need to set it again to restore the user
>  	 * state.  If we entered on the slow path, TF was already set.
>  	 */
> -	if (test_thread_flag(TIF_SINGLESTEP))
> +	if (work & _TIF_SINGLESTEP)
>  		regs->flags |= X86_EFLAGS_TF;

This looks suspicious, but perhaps I misread this change.

If I understand correctly, syscall_trace_enter() can avoid _phase2() above.
But we should always call user_exit() unconditionally?

And we should always set X86_EFLAGS_TF if TIF_SINGLESTEP? IIRC, TF can be
actually cleared on a 32bit kernel if we step over sysenter insn?

Oleg.
