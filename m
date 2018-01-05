From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 16:24:14 -0800
Message-ID: <CAPcyv4iGwQPS8jkWv25GkN=ShqrCKx=cdfK0E3mfF2O1USLVPQ@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop> <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien> <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
 <20180104192648.GA10427@amd> <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
 <CA+55aFwRh++2cyfi1ZXnWCwGv=kuSjft-RcSCDW89T5g=0RB2Q@mail.gmail.com>
 <20180104225515.13a40f0f@alans-desktop> <CA+55aFxNqWQcMQmpbsRhhfb7M8ch30627AkEsswaNk-=MvZo5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36915 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeAEAYQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 19:24:16 -0500
Received: by mail-ot0-f194.google.com with SMTP id p31so2749152ota.4
        for <linux-arch@vger.kernel.org>; Thu, 04 Jan 2018 16:24:16 -0800 (PST)
In-Reply-To: <CA+55aFxNqWQcMQmpbsRhhfb7M8ch30627AkEsswaNk-=MvZo5w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, Julia Lawall <julia.lawall@lip6.fr>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jan 4, 2018 at 3:06 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jan 4, 2018 at 2:55 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>>
>> How do you ensure that the CPU doesn't speculate j < _m  ? ~0 : 0 pick the
>> wrong mask and then reference base[] ?
>
> .. yeah, that's exactly where we want to make sure that the compiler
> uses a select or 'setb'.
>
> That's what gcc does for me in testing:
>
>         xorl    %eax, %eax
>         setbe   %al
>         negq    %rax
>
>  but yes, we'd need to guarantee it somehow.
>
> Presumably that is where we end up having some arch-specific stuff.
> Possibly there is some gcc builtin. I wanted to avoid actually writing
> architecture-specific asm.
>
>> Anding with a constant works because the constant doesn't get speculated
>> and nor does the and with a constant, but you've got a whole additional
>> conditional path in your macro.
>
> Absolutely. Think of it as an example, not "the solution".
>
> It's also possible that x86 'lfence' really is so fast that it doesn't
> make sense to try to do this. Agner Fog claims that it's single-cycle
> (well, except for P4, surprise, surprise), but I suspect that his
> timings are simply for 'lfence' in a loop or something. Which may not
> show the real cost of actually halting things until they are stable.
>
> Also, maybe that __fcheck_files() pattern where getting a NULL pointer
> happens to be the right thing for out-of-range is so unusual as to be
> useless, and most people end up having to have that limit check for
> other reasons anyway.

This potential barrier avoidance optimization technique is something
that could fit in the nospec_{ptr,load,array_load} interface that Mark
defined for ARM, and is constructed around a proposed compiler
builtin. Although, lfence is not a full serializing instruction, so
before we spend too much effort trying to kill it we should measure
how bad it is in practice in these paths.

At this point I'll go ahead with rewriting the osb() patches into
using Mark's nospec_* accessors plus the if_nospec macro. We can kill
the barrier in if_nospec once we are sure the compiler will always "Do
the Right Thing" with the array_access() approach, and can otherwise
make the array_access() approach the 'best-effort' default fallback.
