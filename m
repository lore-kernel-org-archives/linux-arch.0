From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 7/7] tools: add userspace linker table sandbox
Date: Tue, 23 Aug 2016 22:28:39 -0400
Message-ID: <CAGXu5j+JsFAUJ4AfCvK2FVE3TOOeLjyiOD1Buy-X4oRHu=Cz=A@mail.gmail.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org> <1471642875-5957-8-git-send-email-mcgrof@kernel.org>
 <CAGXu5jKX-VZR_r9wMsnLAU+Z10vB4yDiRPpvwXbRZj0=wU208A@mail.gmail.com>
 <20160823000739.GX3296@wotan.suse.de> <201608230028.u7N0SneR020502@mail.zytor.com>
 <20160823143028.GA2834@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37487 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbcHXC3T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2016 22:29:19 -0400
Received: by mail-wm0-f43.google.com with SMTP id i5so6596864wmg.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Aug 2016 19:28:41 -0700 (PDT)
In-Reply-To: <20160823143028.GA2834@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, mhiramat@kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, jbaron@akamai.com, Heiko Carstens <heiko.carstens@de.ibm.com>, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, "David S. Miller" <davem@davemloft.net>, Miao Steven <realmz6@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Rusty Russell <rusty@rustcorp.com.au>, gnomes@lxorguk.ukuu.org.u

On Tue, Aug 23, 2016 at 10:30 AM, Arnaldo Carvalho de Melo
<acme@redhat.com> wrote:
> Em Mon, Aug 22, 2016 at 05:28:42PM -0700, H. Peter Anvin escreveu:
>> On August 22, 2016 5:07:39 PM PDT, "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
>> >On Fri, Aug 19, 2016 at 03:31:47PM -0700, Kees Cook wrote:
>> >> On Fri, Aug 19, 2016 at 2:41 PM,  <mcgrof@kernel.org> wrote:
>> >> >  tools/Makefile                                     |   3 +-
>> >> >  .../arch/x86/include/generated/asm/section-core.h  |   1 +
>> >> >  tools/arch/x86/include/generated/ranges.h          |   1 +
>> >> >  tools/arch/x86/include/generated/tables.h          |   1 +
>> >> >  tools/include/asm-generic/ranges.h                 | 103 ++++
>> >> >  tools/include/asm-generic/section-core.h           | 341
>
>> >> >  tools/include/asm-generic/tables.h                 |  50 ++
>
>> >> Aren't a bunch of these files exact duplicates of the headers in
>> >include/linux?
>
>> >Indeed... This a userspace tools/ architecture decision that was made
>> >long ago, so its not up to me, I am just following the strategy
>> >devised and picked up.  Refer to
>> >7d7d1bf1d1dabe435ef50efb051724b8664749cb ("perf bench: Copy kernel
>> >files needed to build mem{cpy,set} x86_64 benchmarks") for an example
>> >of previous similar work. By sharing header files this enable more
>> >tools/ to be hacked on.
>
>> I think this is a legacy from before the uapi change that should
>> really be fixed.  If we need to export additional kernel structures
>> for the tools, we could define a third level of we really need it.
>
> No, it is something recent, its just that from time to time files that
> tools/ included from outside, i.e. from the kernel sources, made tools/
> break, so after discussion with Linus and Ingo[1], it was decided we would

This [1] reference seems missing. I'm curious to see the thread. I
wonder if something could be done to just generate the needed headers
from the canonical locations into the tools/ locations?

> grab copies and never more access anything outside tools/ directly.
>
> Instead we would check for changes and warn the tools/ developers about
> it, so that they could check what has changed, that could mean changes
> should/could be done to tools/ using those headers.

Is there anything automated in place to notice when these changes happen?

-Kees

-- 
Kees Cook
Nexus Security
