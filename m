From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] kconfig.h: remove config_enabled() macro
Date: Thu, 20 Oct 2016 14:44:02 +0200
Message-ID: <1476967442.28989.38.camel@tiscali.nl>
References: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com>
         <1476957892.28989.24.camel@tiscali.nl>
         <CAK7LNATp2vta0_Qzcs-TuXAX8jQejZyLXiqKKvfi8M=NLtxgAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lb2-smtp-cloud3.xs4all.net ([194.109.24.26]:53253 "EHLO
        lb2-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934152AbcJTMoK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Oct 2016 08:44:10 -0400
In-Reply-To: <CAK7LNATp2vta0_Qzcs-TuXAX8jQejZyLXiqKKvfi8M=NLtxgAA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>

[Added Nicolas.]

On Thu, 2016-10-20 at 21:06 +0900, Masahiro Yamada wrote:
> 2016-10-20 19:04 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
> > On Sun, 2016-10-16 at 20:07 +0900, Masahiro Yamada wrote:
> > There are about a dozen instances of IS_ENABLED() that target something
> > other than a kconfig macros. Are you planning to convert those to
> > __is_defined() too?
> 
> I did not notice that, but looks like there are some to be checked.

Are you willing to do that or should I give it a try (after this patch
has landed, of course)?

> > > --- a/include/linux/kconfig.h
> > > +++ b/include/linux/kconfig.h
> > > @@ -31,7 +31,6 @@
> > >   * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
> > >   * the last step cherry picks the 2nd arg, we get a zero.
> > >   */
> > > -#define config_enabled(cfg)          ___is_defined(cfg)
> > 
> > Is there a reason to keep using the double underscore prefix?
> 
> I followed the suggestion in the following message:
> 
> https://lkml.org/lkml/2016/6/6/944

Nicolas: was there any specific reason to suggest __is_defined() and
not, say, is_defined()?

> > >  #define __is_defined(x)                      ___is_defined(x)
> > >  #define
> > > ___is_defined(val)           ____is_defined(__ARG_PLACEHOLDER_##v
> > > al)
> > >  #define ____is_defined(arg1_or_junk)
> > > __take_second_arg(arg1_or_junk 1, 0)
> > 
> > __is_defined() is now meant to be used generally, and not just on
> > kconfig macros. Can it be moved into another header?
> 
> Currently, __is_defined() is only used in two places:
> 
> include/linux/export.h
> include/asm-generic/export.h
> 
> Even if we fix something like IS_ENABLED(DEBUG),
> we do not have many for now,
> but perhaps will it be used more widely in the future?
> 
> If so, do we need to add  IS_DEFINED() or is_defined()?

Either is fine with me. I'll gladly defer to anyone with good taste in
naming things.

> in include/linux/kconfig.h ?  or include/linux/kernel.h ?

kernel.h seems to be included just about anywhere and it contains
various preprocessor macros of general utility. So that looks like a
fine candidate. Would it be a problem to put it there?

Thanks,


Paul Bolle
