From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/5] kernel: tracepoints: add support for relative
 references
Date: Fri, 18 Aug 2017 19:58:40 +0200
Message-ID: <20170818175840.outgxwdf7t5xjnyk@gmail.com>
References: <20170814105231.14608-1-ard.biesheuvel@linaro.org>
 <20170814105231.14608-6-ard.biesheuvel@linaro.org>
 <20170818082616.vyk5z5s2kicc66ip@gmail.com>
 <CAKv+Gu8KfR989AXv6HGhG=xJsze-RQpKt3A1jiZ-djHdKXeMrg@mail.gmail.com>
 <CAKv+Gu-XKSCno32+bHQ-HM51hUvmQKc=DTw1q0FAKU_JR5kYsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34203 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdHRR6p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 13:58:45 -0400
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-XKSCno32+bHQ-HM51hUvmQKc=DTw1q0FAKU_JR5kYsQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 18 August 2017 at 09:36, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 18 August 2017 at 09:26, Ingo Molnar <mingo@kernel.org> wrote:
> >>
> >> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>
> >>> -static void for_each_tracepoint_range(struct tracepoint * const *begin,
> >>> -             struct tracepoint * const *end,
> >>> +static void for_each_tracepoint_range(const void *begin, const void *end,
> >>>               void (*fct)(struct tracepoint *tp, void *priv),
> >>>               void *priv)
> >>>  {
> >>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> >>> +     const signed int *iter;
> >>> +
> >>> +     if (!begin)
> >>> +             return;
> >>> +     for (iter = begin; iter < (signed int *)end; iter++) {
> >>> +             fct((struct tracepoint *)((unsigned long)iter + *iter), priv);
> >>> +     }
> >>
> >> I think checkpatch is correct here to complain about the unnecessary curly braces
> >> here.
> >>
> >
> > Fair enough. I will clean up to the extent feasible.
> >
> 
> OK, in an honest attempt to at least remove as many of the checkpatch
> errors as I can,  [...]

Note that I actually agreed with your list of checkpatch bogosities - the one I 
commented on was the only thing that needed fixing, IMHO.

Thanks,

	Ingo
