From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Date: Wed, 19 Feb 2020 09:34:45 -0500
Message-ID: <20200219093445.386f1c09@gandalf.local.home>
References: <20200219045423.54190-1-natechancellor@gmail.com>
        <20200219045423.54190-4-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbgBSOet (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 09:34:49 -0500
In-Reply-To: <20200219045423.54190-4-natechancellor@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, clang-built-linux@googlegroups.com

On Tue, 18 Feb 2020 21:54:20 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns:
> 
> ../kernel/trace/trace.c:9335:33: warning: array comparison always
> evaluates to true [-Wtautological-compare]
>         if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
>                                        ^
> 1 warning generated.
> 
> These are not true arrays, they are linker defined symbols, which are
> just addresses so there is not a real issue here. Use the
> COMPARE_SECTIONS macro to silence this warning by casting the linker
> defined symbols to unsigned long, which keeps the logic the same.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/765
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c797a15a1fc7..e1f3b16e457b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
>  		goto out_free_buffer_mask;
>  
>  	/* Only allocate trace_printk buffers if a trace_printk exists */
> -	if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> +	if (COMPARE_SECTIONS(__stop___trace_bprintk_fmt, !=, __start___trace_bprintk_fmt))

Sorry, but this is really ugly and unreadable. Please find some other
solution to fix this.

NAK-by: Steven Rostedt

-- Steve

>  		/* Must be called before global_trace.buffer is allocated */
>  		trace_printk_init_buffers();
>  
