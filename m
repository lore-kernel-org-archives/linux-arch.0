From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4/8] kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
Date: Tue, 20 Nov 2018 10:13:53 +0900
Message-ID: <CAK7LNARvZZa-RgLCs9hwwgwrH-frxL6H1a3=BQzHmVqX6sPhTw@mail.gmail.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
 <1542270435-11181-5-git-send-email-yamada.masahiro@socionext.com>
 <nycvar.YSQ.7.76.1811152346510.1993@knanqh.ubzr> <CAK7LNATT7PYvH-z572MGSjXbCybAW0TcNebz9CgGM4J07aMOvw@mail.gmail.com>
 <nycvar.YSQ.7.76.1811161234160.1993@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YSQ.7.76.1811161234160.1993@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Nicolas,


On Sat, Nov 17, 2018 at 2:50 AM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> > > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > > index 7f3ca6e..e5ba9b1 100644
> > > > --- a/scripts/Makefile.build
> > > > +++ b/scripts/Makefile.build
> > > > @@ -254,9 +254,18 @@ objtool_dep = $(objtool_obj)                                     \
> > > >             $(wildcard include/config/orc/unwinder.h          \
> > > >                        include/config/stack/validation.h)
> > > >
> > > > +ifdef CONFIG_TRIM_UNUSED_KSYMS
> > > > +cmd_gen_ksymdeps = \
> > > > +     $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ > $(dot-target).tmp; \
> > > > +     cat $(dot-target).tmp >> $(dot-target).cmd; \
> > > > +     rm -f $(dot-target).tmp;
> > >
> > > Why don't you append to $(dot-target).cmd directly?
> >
> >
> > If scripts/gen_ksymdeps.sh fails for some reasons,
> > it will error out immediately thanks to 'set -e' flag.
> >
> > Appending incomplete portion might end up with a corrupted .*.cmd file.
> >
> > Probably, that would not happen, but I just wanted to ensure it.
>
> Well, strictly speaking, if scripts/gen_ksymdeps.sh fails and its output
> isn't appended at all to the .*.cmd file, then that .*.cmd file is
> already corrupted as it is missing necessary dependencies. Would be
> better to delete the .*.cmd file entirely in that case.


More strictly speaking, missing necessary dependencies is not a big deal.

Now, scripts/Kbuild.include specifies .DELETE_ON_ERROR

Any error in fixdep, gen_ksymdeps.sh, or whatever
will delete *.o file anyway.

So, I change the course
so that fixdep and gen_ksymdeps.sh directly write to .*.cmd files.


I wrote detailed explanation here:
https://patchwork.kernel.org/patch/10689697/




-- 
Best Regards
Masahiro Yamada
