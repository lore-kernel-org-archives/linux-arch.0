Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:37930 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbdHRNyc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 09:54:32 -0400
Received: by mail-it0-f47.google.com with SMTP id o72so6319600ita.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 06:54:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170818095206.565b6e4c@gandalf.local.home>
References: <20170818112624.24991-1-ard.biesheuvel@linaro.org>
 <20170818112624.24991-7-ard.biesheuvel@linaro.org> <CAKv+Gu8tA58HaD4cBMqrBagQfCd55mZ3H1JVpECY+xEqOOuVVA@mail.gmail.com>
 <20170818094338.5370cdad@gandalf.local.home> <CAKv+Gu-Uoj6sboXOhwme5dgQpmJ=cECu==5Pn0HNHTw2VxNz5g@mail.gmail.com>
 <20170818095206.565b6e4c@gandalf.local.home>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 18 Aug 2017 14:54:31 +0100
Message-ID: <CAKv+Gu_QrCkx6-9c9q1tSktNVpvhZ0bJ4nCqd7-LnXvbS=dYig@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] kernel: tracepoints: add support for relative references
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Nicolas Pitre <nico@linaro.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>, Jessica Yu <jeyu@kernel.org>
Message-ID: <20170818135431.unP7SkMpD_hINvWH6MWq40UeBb2wI0fdmtJFhRvL6CY@z>

On 18 August 2017 at 14:52, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 18 Aug 2017 14:44:15 +0100
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> >> It appears the stuff above needs to be move inside the double-include
>> >> guard (which oddly enough does not cover the entire file)
>> >
>> > Why was this moved to the header file? To fulfill some checkpatch
>> > warning?
>> >
>>
>> Yes.
>
> My preference is to ignore that checkpatch warning. The section
> variables are created by linker magic, and not normal "extern"
> variables. They are only used in one location, and I like to keep them
> where they are used, and not be something other places might think they
> can be used. In other words, keep them by the C code, and out of
> headers.
>
> Tracepoints and linker/asm work always triggers a lot of bogus
> checkpatch warnings. Which is unfortunate. :-/
>

Actually, I couldn't agree more. I will backpedal on the checkpatch
appeasement in v3 in general.

Thanks,
Ard.
