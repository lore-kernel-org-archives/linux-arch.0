From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 3/5] x86: Split syscall_trace_enter into two phases
Date: Tue, 29 Jul 2014 21:25:55 +0200
Message-ID: <20140729192555.GB6308@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net> <714cf438762d342673b3b131d5c90bc69ca921a9.1406604806.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <714cf438762d342673b3b131d5c90bc69ca921a9.1406604806.git.luto@amacapital.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: linux-arch.vger.kernel.org

On 07/28, Andy Lutomirski wrote:
>
> +long syscall_trace_enter_phase2(struct pt_regs *regs, u32 arch,
> +				unsigned long phase1_result)
> +{
> +	long ret = 0;
> +	u32 work = ACCESS_ONCE(current_thread_info()->flags) &
> +		_TIF_WORK_SYSCALL_ENTRY;
> +
> +	BUG_ON(regs != task_pt_regs(current));
>  
>  	/*
>  	 * If we stepped into a sysenter/syscall insn, it trapped in
> @@ -1463,17 +1569,20 @@ long syscall_trace_enter(struct pt_regs *regs)
>  	 * do_debug() and we need to set it again to restore the user
>  	 * state.  If we entered on the slow path, TF was already set.
>  	 */
> -	if (test_thread_flag(TIF_SINGLESTEP))
> +	if (work & _TIF_SINGLESTEP)
>  		regs->flags |= X86_EFLAGS_TF;

This is minor, I won't argue, but this can be moved into phase1(), afaics.

Oleg.
