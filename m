Return-Path: <frowand.list@gmail.com>
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200228012036.15682-5-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e5de96ed-fb76-d322-fa40-c6e870e76c36@gmail.com>
Date: Mon, 2 Mar 2020 13:13:03 -0600
MIME-Version: 1.0
In-Reply-To: <20200228012036.15682-5-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200302191303.P1Aj11dPA2W15vTEoY4dDBGjB6Ohkxff63ucfjk8-z0@z>

On 2/27/20 7:20 PM, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/kunit/test.h | 9 +++++++++
>  init/main.c          | 4 ++++
>  lib/kunit/executor.c | 4 +---
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8a02f93a6b505..8689dd1459844 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -197,6 +197,15 @@ void kunit_init_test(struct kunit *test, const char *name);
>  
>  int kunit_run_tests(struct kunit_suite *suite);
>  
> +#if IS_BUILTIN(CONFIG_KUNIT)

I suspected this would not work if a unittest was builtin but CONFIG_KUNIT
was set to module.

So I decided to experiment a bit to verify my assumptions (before applying
this patch series).  I tried to set CONFIG_KUNIT to module, then set
CONFIG_KUNIT_EXAMPLE_TEST to built in.  Kconfig does not let me do this
because KUNIT_EXAMPLE_TEST is inside a 'if KUNIT' in lib/kunit/Kconfig,
but instead switches KUNIT_EXAMPLE_TEST to a module, and warns that it
has done so.  This was a bit of a surprise, but seems reasonable.

So my next assumption is that the architecture of KUnit expects
each individual unit test config option to depend upon CONFIG_KUNIT.
If this is the case, please clearly document that requirement in
the KUnit documentation.


> +int kunit_run_all_tests(void);
> +#else
> +static inline int kunit_run_all_tests(void)
> +{
> +	return 0;
> +}
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> +
>  /*
>   * If a test suite is built-in, module_init() gets translated into
>   * an initcall which we don't want as the idea is that for builtins
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
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 6429927d598a5..b75a46c560847 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -11,7 +11,7 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>  
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  
> -static int kunit_run_all_tests(void)
> +int kunit_run_all_tests(void)
>  {
>  	struct kunit_suite * const * const *suites, * const *subsuite;
>  	bool has_test_failed = false;
> @@ -31,6 +31,4 @@ static int kunit_run_all_tests(void)
>  	return 0;
>  }
>  
> -late_initcall(kunit_run_all_tests);
> -
>  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
> 
