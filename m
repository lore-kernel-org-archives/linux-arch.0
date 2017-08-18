Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34293 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdHRJYM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 05:24:12 -0400
Received: by mail-io0-f174.google.com with SMTP id o9so31379076iod.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 02:24:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8KfR989AXv6HGhG=xJsze-RQpKt3A1jiZ-djHdKXeMrg@mail.gmail.com>
References: <20170814105231.14608-1-ard.biesheuvel@linaro.org>
 <20170814105231.14608-6-ard.biesheuvel@linaro.org> <20170818082616.vyk5z5s2kicc66ip@gmail.com>
 <CAKv+Gu8KfR989AXv6HGhG=xJsze-RQpKt3A1jiZ-djHdKXeMrg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 18 Aug 2017 10:24:10 +0100
Message-ID: <CAKv+Gu-XKSCno32+bHQ-HM51hUvmQKc=DTw1q0FAKU_JR5kYsQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] kernel: tracepoints: add support for relative references
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Jessica Yu <jeyu@kernel.org>
Message-ID: <20170818092410.4uMWQ8teelYz2GcA7E-Mnnx5hyvtqfShP0ZrXLoPnjg@z>

On 18 August 2017 at 09:36, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 18 August 2017 at 09:26, Ingo Molnar <mingo@kernel.org> wrote:
>>
>> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>>> -static void for_each_tracepoint_range(struct tracepoint * const *begin,
>>> -             struct tracepoint * const *end,
>>> +static void for_each_tracepoint_range(const void *begin, const void *end,
>>>               void (*fct)(struct tracepoint *tp, void *priv),
>>>               void *priv)
>>>  {
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +     const signed int *iter;
>>> +
>>> +     if (!begin)
>>> +             return;
>>> +     for (iter = begin; iter < (signed int *)end; iter++) {
>>> +             fct((struct tracepoint *)((unsigned long)iter + *iter), priv);
>>> +     }
>>
>> I think checkpatch is correct here to complain about the unnecessary curly braces
>> here.
>>
>
> Fair enough. I will clean up to the extent feasible.
>

OK, in an honest attempt to at least remove as many of the checkpatch
errors as I can, I am running into the paradoxical situation where I
either get

ERROR: space required after that ',' (ctx:VxO)
#83: FILE: include/linux/init.h:232:
+#define console_initcall(fn) ___define_initcall(fn,, .con_initcall)

or

ERROR: space prohibited before that ',' (ctx:WxW)
#156: FILE: include/linux/init.h:232:
+#define console_initcall(fn) ___define_initcall(fn, , .con_initcall)
                                                    ^
which I think may be checkpatch trying to give me a hint that I have
done enough work for the week, and should spend some time by the pool
instead.
