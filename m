Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfFZPAi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 11:00:38 -0400
From: Florian Weimer <fweimer@redhat.com>
Subject: Re: Detecting the availability of VSYSCALL
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de>
        <87lfxpy614.fsf@oldenburg2.str.redhat.com>
        <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com>
        <87a7e5v1d9.fsf@oldenburg2.str.redhat.com>
        <CALCETrUDt4v3=FqD+vseGTKTuG=qY+1LwRPrOrU8C7vCVbo=uA@mail.gmail.com>
        <87o92kmtp5.fsf@oldenburg2.str.redhat.com>
        <CA96B819-30A9-43D3-9FE3-2D551D35369E@amacapital.net>
Date: Wed, 26 Jun 2019 17:00:28 +0200
In-Reply-To: <CA96B819-30A9-43D3-9FE3-2D551D35369E@amacapital.net> (Andy
        Lutomirski's message of "Wed, 26 Jun 2019 07:15:59 -0700")
Message-ID: <87r27gjss3.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux API <linux-api@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-x86_64@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Carlos O'Donell <carlos@redhat.com>, X86 ML <x86@kernel.org>
Message-ID: <20190626150028.UaE1p2_i3BJUmCMU_OnhKBRyW_B9j_zX05R4w075a2A@z>

* Andy Lutomirski:

> I didn’t add a flag because the vsyscall page was thoroughly obsolete
> when all this happened, and I wanted to encourage all new code to just
> parse the vDSO instead of piling on the hacks.

It turned out that the thorny cases just switched to system calls
instead.  I think we finally completed the transition in glibc upstream
in 2018 (for x86).

> Anyway, you may be the right person to ask: is there some credible way
> that the kernel could detect new binaries that don’t need vsyscalls?
> Maybe a new ELF note on a static binary or on the ELF interpreter? We
> can dynamically switch it in principle.

For this kind of change, markup similar to PT_GNU_STACK would have been
appropriate, I think: Old kernels and loaders would have ignored the
program header and loaded the program anyway, but the vsyscall page
still existed, so that would have been fine. The kernel would have
needed to check the program interpreter or the main executable (without
a program interpreter, i.e., the statically linked case).  Due the way
the vsyscalls are concentrated in glibc, a dynamically linked executable
would not have needed checking (or re-linking).  I don't think we would
have implemented the full late enablement after dlopen we did for
executable stacks.  In theory, any code could have jumped to the
vsyscall area, but in practice, it's just dynamically linked glibc and
static binaries.

But nowadays, unmarked glibcs which do not depend on vsyscall vastly
outnumber unmarked glibcs which requrie it.  Therefore, markup of
binaries does not seem to be reasonable to day.  I could imagine a
personality flag you can set (if yoy have CAP_SYS_ADMIN) that re-enables
vsyscall support for new subprocesses.  And a container runtime would do
this based on metadata found in the image.  This way, the container host
itself could be protected, and you could still run legacy images which
require vsyscall.

For the non-container case, if you know that you'll run legacy
workloads, you'd still have the boot parameter.  But I think it could
default to vsyscall=none in many more cases.

Thanks,
Florian
