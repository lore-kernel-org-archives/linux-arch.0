From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4/8] kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
Date: Fri, 16 Nov 2018 16:13:33 +0900
Message-ID: <CAK7LNATT7PYvH-z572MGSjXbCybAW0TcNebz9CgGM4J07aMOvw@mail.gmail.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
 <1542270435-11181-5-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1811152346510.1993@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YSQ.7.76.1811152346510.1993@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 16, 2018 at 2:13 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> On Thu, 15 Nov 2018, Masahiro Yamada wrote:
>
> > My main motivation of this commit is to clean up scripts/Kbuild.include
> > and scripts/Makefile.build.
> >
> > Currently, CONFIG_TRIM_UNUSED_KSYMS works with a tricky gimmick;
> > possibly exported symbols are detected by letting $(CPP) replace
> > EXPORT_SYMBOL* with a special string '=== __KSYM_*===', which is
> > post-processed by sed, and passed to fixdep. The extra preprocessing
> > is costly, and hacking cmd_and_fixdep is ugly.
> >
> > I came up with a new way to find exported symbols; insert a dummy
> > symbol __ksym_marker_* to each potentially exported symbol. Those
> > dummy symbols are picked up by $(NM), post-processed by sed, then
> > appended to .*.cmd files. I collected the post-process part to a
> > new shell script scripts/gen_ksymdeps.sh for readability. The dummy
> > symbols are put into the .discard.* section so that the linker
> > script rips them off the final vmlinux or modules.
>
> Brilliant!  I really like it.
>
> Minor comments below.
>
> > diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> > index 4d73e6e..294d6ae 100644
> > --- a/include/asm-generic/export.h
> > +++ b/include/asm-generic/export.h
> > @@ -59,16 +59,19 @@ __kcrctab_\name:
> >  .endm
> >  #undef __put
> >
> > -#if defined(__KSYM_DEPS__)
> > -
> > -#define __EXPORT_SYMBOL(sym, val, sec)       === __KSYM_##sym ===
> > -
> > -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > +#if defined(CONFIG_TRIM_UNUSED_KSYMS)
> >
> >  #include <linux/kconfig.h>
> >  #include <generated/autoksyms.h>
> >
> > +.macro __ksym_marker sym
> > +     .section ".discard.ksym","a"
> > +__ksym_marker_\sym:
> > +      .previous
>
> Does this work as intended? I have vague memories about having problems
> with sections being discarded when they don't allocate any space.

What I can tell is, this patch produces the same size kernel
(after dropping debug info by 'strip' command).


> > +.endm
> > +
> >  #define __EXPORT_SYMBOL(sym, val, sec)                               \
> > +     __ksym_marker sym;                                      \
> >       __cond_export_sym(sym, val, sec, __is_defined(__KSYM_##sym))
> >  #define __cond_export_sym(sym, val, sec, conf)                       \
> >       ___cond_export_sym(sym, val, sec, conf)
> > diff --git a/include/linux/export.h b/include/linux/export.h
> > index ce764a5..0413a3d 100644
> > --- a/include/linux/export.h
> > +++ b/include/linux/export.h
> > @@ -92,22 +92,22 @@ struct kernel_symbol {
> >   */
> >  #define __EXPORT_SYMBOL(sym, sec)
> >
> > -#elif defined(__KSYM_DEPS__)
> > +#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > +
> > +#include <generated/autoksyms.h>
> >
> >  /*
> >   * For fine grained build dependencies, we want to tell the build system
> >   * about each possible exported symbol even if they're not actually exported.
> > - * We use a string pattern that is unlikely to be valid code that the build
> > - * system filters out from the preprocessor output (see ksym_dep_filter
> > - * in scripts/Kbuild.include).
> > + * We use a symbol pattern __ksym_marker_<symbol> that the build system filters
> > + * from the $(NM) output (see scripts/gen_ksymdep.sh). These symbols are
> > + * discarded in the final link stage.
> >   */
> > -#define __EXPORT_SYMBOL(sym, sec)    === __KSYM_##sym ===
> > -
> > -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> > -
> > -#include <generated/autoksyms.h>
> > +#define __ksym_marker(sym)   \
> > +     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
>
> Even if this is discarded during the final link, maybe this could save
> a tiny amount of disk space by using a char instead?


I am afraid you missed '[0]' after the symbol name.
This is actually zero-length array.

No memory allocated for this dummy section.

As far as I tested, this is working.





> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 7f3ca6e..e5ba9b1 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -254,9 +254,18 @@ objtool_dep = $(objtool_obj)                                     \
> >             $(wildcard include/config/orc/unwinder.h          \
> >                        include/config/stack/validation.h)
> >
> > +ifdef CONFIG_TRIM_UNUSED_KSYMS
> > +cmd_gen_ksymdeps = \
> > +     $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ > $(dot-target).tmp; \
> > +     cat $(dot-target).tmp >> $(dot-target).cmd; \
> > +     rm -f $(dot-target).tmp;
>
> Why don't you append to $(dot-target).cmd directly?


If scripts/gen_ksymdeps.sh fails for some reasons,
it will error out immediately thanks to 'set -e' flag.

Appending incomplete portion might end up with a corrupted .*.cmd file.

Probably, that would not happen, but I just wanted to ensure it.




>
> Nicolas



--
Best Regards
Masahiro Yamada
