From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is not sanitized
Date: Thu, 20 Feb 2020 11:37:32 +0100
Message-ID: <CACT4Y+ZfxqMuiL_UF+rCku628hirJwp3t3vW5WGM8DWG6OaCeg@mail.gmail.com>
References: <20200219144724.800607165@infradead.org> <20200219150745.651901321@infradead.org>
 <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
 <20200219163025.GH18400@hirez.programming.kicks-ass.net> <20200219172014.GI14946@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34323 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgBTKhp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 05:37:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id l16so2517822qtq.1
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 02:37:44 -0800 (PST)
In-Reply-To: <20200219172014.GI14946@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev <kasan-dev@googlegroups.com>

On Wed, Feb 19, 2020 at 6:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 19, 2020 at 05:30:25PM +0100, Peter Zijlstra wrote:
>
> > By inlining everything in poke_int3_handler() (except bsearch :/) we can
> > mark the whole function off limits to everything and call it a day. That
> > simplicity has been the guiding principle so far.
> >
> > Alternatively we can provide an __always_inline variant of bsearch().
>
> This reduces the __no_sanitize usage to just the exception entry
> (do_int3) and the critical function: poke_int3_handler().
>
> Is this more acceptible?

Let's say it's more acceptable.

Acked-by: Dmitry Vyukov <dvyukov@google.com>

I guess there is no ideal solution here.

Just a straw man proposal: expected number of elements is large enough
to make bsearch profitable, right? I see 1 is a common case, but the
other case has multiple entries.

> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -979,7 +979,7 @@ static __always_inline void *text_poke_a
>         return _stext + tp->rel_addr;
>  }
>
> -static int notrace __no_sanitize patch_cmp(const void *key, const void *elt)
> +static __always_inline int patch_cmp(const void *key, const void *elt)
>  {
>         struct text_poke_loc *tp = (struct text_poke_loc *) elt;
>
> @@ -989,7 +989,6 @@ static int notrace __no_sanitize patch_c
>                 return 1;
>         return 0;
>  }
> -NOKPROBE_SYMBOL(patch_cmp);
>
>  int notrace __no_sanitize poke_int3_handler(struct pt_regs *regs)
>  {
> @@ -1024,9 +1023,9 @@ int notrace __no_sanitize poke_int3_hand
>          * Skip the binary search if there is a single member in the vector.
>          */
>         if (unlikely(desc->nr_entries > 1)) {
> -               tp = bsearch(ip, desc->vec, desc->nr_entries,
> -                            sizeof(struct text_poke_loc),
> -                            patch_cmp);
> +               tp = __bsearch(ip, desc->vec, desc->nr_entries,
> +                              sizeof(struct text_poke_loc),
> +                              patch_cmp);
>                 if (!tp)
>                         goto out_put;
>         } else {
> --- a/include/linux/bsearch.h
> +++ b/include/linux/bsearch.h
> @@ -4,7 +4,29 @@
>
>  #include <linux/types.h>
>
> -void *bsearch(const void *key, const void *base, size_t num, size_t size,
> -             cmp_func_t cmp);
> +static __always_inline
> +void *__bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
> +{
> +       const char *pivot;
> +       int result;
> +
> +       while (num > 0) {
> +               pivot = base + (num >> 1) * size;
> +               result = cmp(key, pivot);
> +
> +               if (result == 0)
> +                       return (void *)pivot;
> +
> +               if (result > 0) {
> +                       base = pivot + size;
> +                       num--;
> +               }
> +               num >>= 1;
> +       }
> +
> +       return NULL;
> +}
> +
> +extern void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp);
>
>  #endif /* _LINUX_BSEARCH_H */
> --- a/lib/bsearch.c
> +++ b/lib/bsearch.c
> @@ -28,27 +28,9 @@
>   * the key and elements in the array are of the same type, you can use
>   * the same comparison function for both sort() and bsearch().
>   */
> -void __no_sanitize *bsearch(const void *key, const void *base, size_t num, size_t size,
> -             cmp_func_t cmp)
> +void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
>  {
> -       const char *pivot;
> -       int result;
> -
> -       while (num > 0) {
> -               pivot = base + (num >> 1) * size;
> -               result = cmp(key, pivot);
> -
> -               if (result == 0)
> -                       return (void *)pivot;
> -
> -               if (result > 0) {
> -                       base = pivot + size;
> -                       num--;
> -               }
> -               num >>= 1;
> -       }
> -
> -       return NULL;
> +       __bsearch(key, base, num, size, cmp);
>  }
>  EXPORT_SYMBOL(bsearch);
>  NOKPROBE_SYMBOL(bsearch);
