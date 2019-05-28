From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] tools/objtool: add kasan_check_* to uaccess whitelist
Date: Tue, 28 May 2019 19:19:42 +0200
Message-ID: <20190528171942.GV2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-2-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528163258.260144-2-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
List-Id: linux-arch.vger.kernel.org

On Tue, May 28, 2019 at 06:32:57PM +0200, Marco Elver wrote:
> This is a pre-requisite for enabling bitops instrumentation. Some bitops
> may safely be used with instrumentation in uaccess regions.
> 
> For example, on x86, `test_bit` is used to test a CPU-feature in a
> uaccess region:   arch/x86/ia32/ia32_signal.c:361

That one can easily be moved out of the uaccess region. Any else?

> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  tools/objtool/check.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 172f99195726..eff0e5209402 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -443,6 +443,8 @@ static void add_ignores(struct objtool_file *file)
>  static const char *uaccess_safe_builtin[] = {
>  	/* KASAN */
>  	"kasan_report",
> +	"kasan_check_read",
> +	"kasan_check_write",
>  	"check_memory_region",
>  	/* KASAN out-of-line */
>  	"__asan_loadN_noabort",
> -- 
> 2.22.0.rc1.257.g3120a18244-goog
> 
