Return-Path: <keescook@chromium.org>
Date: Mon, 2 Mar 2020 14:45:30 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
Message-ID: <202003021439.A6B6FD8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228012036.15682-5-brendanhiggins@google.com>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200302224530.MySgamhC_QUK4d6aIyc0G5BeiZoVLupEx2GjPgzpdCg@z>

On 2/27/20 7:20 PM, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> [...]
> diff --git a/init/main.c b/init/main.c
> index ee4947af823f3..7875a5c486dc4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -104,6 +104,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/initcall.h>
>  
> +#include <kunit/test.h>
> +
>  static int kernel_init(void *);
>  
>  extern void init_IRQ(void);
> @@ -1444,6 +1446,8 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	do_basic_setup();
>  
> +	kunit_run_all_tests();
> +
>  	console_on_rootfs();
>  
>  	/*

I'm nervous about this happening before two key pieces of the kernel
setup, which might lead to weird timing-sensitive bugs or false
positives:
	async_synchronize_full()
	mark_readonly()

Now, I realize kunit tests _should_ be self-contained, but this seems
like a possible robustness problem. Is there any reason this can't be
moved after rcu_end_inkernel_boot() in kernel_init() instead?

-- 
Kees Cook
