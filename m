From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V4 04/15] entry: Provide generic interrupt entry/exit code
Date: Wed, 29 Jul 2020 14:18:22 +0200
Message-ID: <87sgdaa50x.fsf@nanos.tec.linutronix.de>
References: <20200721105706.030914876@linutronix.de> <20200721110808.671110583@linutronix.de> <CALCETrUBQa=L_Chd=RAPDEihvUWC_9KoHG00zYsGOwiYg87naQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:41764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2020 08:18:24 -0400
In-Reply-To: <CALCETrUBQa=L_Chd=RAPDEihvUWC_9KoHG00zYsGOwiYg87naQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, Gabriel Krisman Bertazi <krisman@collabora.com>

Andy Lutomirski <luto@kernel.org> writes:
> On Tue, Jul 21, 2020 at 4:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Like the syscall entry/exit code interrupt/exception entry after the real
>> low level ASM bits should not be different accross architectures.
>>
>> Provide a generic version based on the x86 code.
>
> I don't like the name.  Sure, idtentry is ugly and x86-specific, but
> irq gives the wrong impression.  This is an entry path suitable for
> any entry that is guaranteed not to hit during entry/exit handling.
> Syscalls, page faults, etc are not "irqs".

Yeah, it's exceptions and interrupts, but I did not come up with a
better name so far.

Thanks,

        tglx
