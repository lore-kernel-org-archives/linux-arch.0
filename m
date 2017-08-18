From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 6/6] kernel: tracepoints: add support for relative references
Date: Fri, 18 Aug 2017 12:44:17 +0100
Message-ID: <CAKv+Gu8tA58HaD4cBMqrBagQfCd55mZ3H1JVpECY+xEqOOuVVA@mail.gmail.com>
References: <20170818112624.24991-1-ard.biesheuvel@linaro.org> <20170818112624.24991-7-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36870 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdHRLoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 07:44:19 -0400
Received: by mail-it0-f45.google.com with SMTP id 76so5935205ith.0
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 04:44:19 -0700 (PDT)
In-Reply-To: <20170818112624.24991-7-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Nicolas Pitre <nico@linaro.org>, Steve

On 18 August 2017 at 12:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> To avoid the need for relocating absolute references to tracepoint
> structures at boot time when running relocatable kernels (which may
> take a disproportionate amount of space), add the option to emit
> these tables as relative references instead.
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  include/linux/tracepoint.h | 42 ++++++++++++++++++--
>  kernel/tracepoint.c        |  7 +---
>  2 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index a26ffbe09e71..68701821933a 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -228,6 +228,42 @@ extern void syscall_unregfunc(void);
>                 return static_key_false(&__tracepoint_##name.key);      \
>         }
>
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#define __TRACEPOINT_ENTRY(name)                                       \
> +       asm("   .section \"__tracepoints_ptrs\", \"a\"\n"               \
> +           "   .balign 4\n"                                            \
> +           "   .long " VMLINUX_SYMBOL_STR(__tracepoint_##name) " - .\n"\
> +           "   .previous\n")
> +
> +struct tracepoint_entry_t {
> +       int tp_offset;
> +};
> +
> +static inline
> +struct tracepoint *tracepoint_from_entry(const struct tracepoint_entry_t *ent)
> +{
> +       return (struct tracepoint *)((unsigned long)ent + ent->tp_offset);
> +}
> +#else
> +#define __TRACEPOINT_ENTRY(name)                                        \
> +       static struct tracepoint * const __tracepoint_ptr_##name __used  \
> +       __attribute__((section("__tracepoints_ptrs"))) =                 \
> +               &__tracepoint_##name
> +
> +struct tracepoint_entry_t {
> +       struct tracepoint *tp;
> +};
> +
> +static inline
> +struct tracepoint *tracepoint_from_entry(const struct tracepoint_entry_t *ent)
> +{
> +       return ent->tp;
> +}
> +#endif
> +
> +extern struct tracepoint_entry_t const __start___tracepoints_ptrs[];
> +extern struct tracepoint_entry_t const __stop___tracepoints_ptrs[];
> +

It appears the stuff above needs to be move inside the double-include
guard (which oddly enough does not cover the entire file)

>  /*
>   * We have no guarantee that gcc and the linker won't up-align the tracepoint
>   * structures, so we create an array of pointers that will be used for iteration
> @@ -237,11 +273,9 @@ extern void syscall_unregfunc(void);
>         static const char __tpstrtab_##name[]                            \
>         __attribute__((section("__tracepoints_strings"))) = #name;       \
>         struct tracepoint __tracepoint_##name                            \
> -       __attribute__((section("__tracepoints"))) =                      \
> +       __attribute__((section("__tracepoints"))) __used =               \
>                 { __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
> -       static struct tracepoint * const __tracepoint_ptr_##name __used  \
> -       __attribute__((section("__tracepoints_ptrs"))) =                 \
> -               &__tracepoint_##name;
> +       __TRACEPOINT_ENTRY(name);
>
>  #define DEFINE_TRACE(name)                                             \
>         DEFINE_TRACE_FN(name, NULL, NULL);
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 685c50ae6300..21bc41454fd6 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -28,9 +28,6 @@
>  #include <linux/sched/task.h>
>  #include <linux/static_key.h>
>
> -extern struct tracepoint * const __start___tracepoints_ptrs[];
> -extern struct tracepoint * const __stop___tracepoints_ptrs[];
> -
>  /* Set to 1 to enable tracepoint debug output */
>  static const int tracepoint_debug;
>
> @@ -508,12 +505,12 @@ static void for_each_tracepoint_range(struct tracepoint * const *begin,
>                 void (*fct)(struct tracepoint *tp, void *priv),
>                 void *priv)
>  {
> -       struct tracepoint * const *iter;
> +       struct tracepoint_entry_t const *iter;
>
>         if (!begin)
>                 return;
>         for (iter = begin; iter < end; iter++)
> -               fct(*iter, priv);
> +               fct(tracepoint_from_entry(iter), priv);
>  }
>
>  /**
> --
> 2.11.0
>
