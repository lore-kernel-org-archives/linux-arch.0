From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 2/5] x86,entry: Only call user_exit if TIF_NOHZ
Date: Tue, 29 Jul 2014 21:32:32 +0200
Message-ID: <20140729193232.GA8153@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net> <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net>
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
> @@ -1449,7 +1449,12 @@ long syscall_trace_enter(struct pt_regs *regs)
>  {
>  	long ret = 0;
>  
> -	user_exit();
> +	/*
> +	 * If TIF_NOHZ is set, we are required to call user_exit() before
> +	 * doing anything that could touch RCU.
> +	 */
> +	if (test_thread_flag(TIF_NOHZ))
> +		user_exit();

Personally I still think this change just adds more confusion, but I leave
this to you and Frederic.

It is not that "If TIF_NOHZ is set, we are required to call user_exit()", we
need to call user_exit() just because we enter the kernel. TIF_NOHZ is just
the implementation detail which triggers this slow path.

At least it should be correct, unless I am confused even more than I think.

Oleg.
