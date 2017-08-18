From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 5/5] kernel: tracepoints: add support for relative references
Date: Fri, 18 Aug 2017 09:36:31 +0100
Message-ID: <CAKv+Gu8KfR989AXv6HGhG=xJsze-RQpKt3A1jiZ-djHdKXeMrg@mail.gmail.com>
References: <20170814105231.14608-1-ard.biesheuvel@linaro.org>
 <20170814105231.14608-6-ard.biesheuvel@linaro.org> <20170818082616.vyk5z5s2kicc66ip@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36014 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdHRIgd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 04:36:33 -0400
Received: by mail-io0-f179.google.com with SMTP id g35so30882932ioi.3
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 01:36:32 -0700 (PDT)
In-Reply-To: <20170818082616.vyk5z5s2kicc66ip@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

On 18 August 2017 at 09:26, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> -static void for_each_tracepoint_range(struct tracepoint * const *begin,
>> -             struct tracepoint * const *end,
>> +static void for_each_tracepoint_range(const void *begin, const void *end,
>>               void (*fct)(struct tracepoint *tp, void *priv),
>>               void *priv)
>>  {
>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>> +     const signed int *iter;
>> +
>> +     if (!begin)
>> +             return;
>> +     for (iter = begin; iter < (signed int *)end; iter++) {
>> +             fct((struct tracepoint *)((unsigned long)iter + *iter), priv);
>> +     }
>
> I think checkpatch is correct here to complain about the unnecessary curly braces
> here.
>

Fair enough. I will clean up to the extent feasible.

> Plus why the heavy use of 'signed int' here and elsewhere in the patches - why
> not 'int' ?
>

Yes, just 'int' should be sufficient. Force of habit, I suppose, given
that unqualified 'char' is ambiguous between architectures, but this
does not apply to 'int' of course.

> Plus #2, the heavy use of type casts looks pretty ugly to begin with - is there no
> way to turn this into more natural code?
>

Actually, Steven requested to keep the tracepoint section markers as
they are, and cast them to (int *) in the conditionally compiled
PREL32 case. So I guess it is a matter of taste, but because the types
are fundamentally incompatible when this code is in effect (and the
size of the pointed-to type differs on 64-bit architectures), there is
always some mangling required.

The initcall patch is probably the cleanest in this regard, but
involves typedefs, which are frowned upon as well.
