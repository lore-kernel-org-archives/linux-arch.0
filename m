From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
Date: Fri, 7 Dec 2018 14:33:17 +0000 (GMT)
Message-ID: <alpine.LFD.2.21.1812062141300.22112@eddie.linux-mips.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>        <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com>        <20181205063436.kzxgnvgexcgq572k@pburton-laptop>        <alpine.LFD.2.21.1812061209220.7193@eddie.linux-mips.org>
        <alpine.DEB.2.21.1812061618110.12167@digraph.polyomino.org.uk>        <alpine.LFD.2.21.1812061659210.4294@eddie.linux-mips.org>        <alpine.DEB.2.21.1812061719180.12167@digraph.polyomino.org.uk>        <alpine.LFD.2.21.1812061729340.4294@eddie.linux-mips.org>
 <87mupiikzy.fsf@oldenburg2.str.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992798AbeLGOdRhC0sC (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 1 other);
        Fri, 7 Dec 2018 15:33:17 +0100
In-Reply-To: <87mupiikzy.fsf@oldenburg2.str.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Weimer <fweimer@redhat.com>
Cc: Joseph Myers <joseph@codesourcery.com>, Paul Burton <paul.burton@mips.com>, Firoz Khan <firoz.khan@linaro.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, libc-alpha@sourceware.org
List-Id: linux-arch.vger.kernel.org

On Thu, 6 Dec 2018, Florian Weimer wrote:

> >  I seem to remember having to take extra care with how the three MIPS ABIs 
> > wire the syscalls to get it right in glibc, but I take it then this has 
> > been now addressed reliably enough for the glibc not to care how exactly
> > <asm/unistd.h> has been arranged.
> 
> This is a fairly recent change (commit
> 2dba5ce7b8115d6a2789bf279892263621088e74, "<bits/syscall.h>: Use an
> arch-independent system call list on Linux", first release with it is
> glibc 2.27).  This patch is quite backportable; we have put it into our
> 2.17-derived glibc, and the upstream work was originally driven by
> downstream ordering requirements of kernel header and glibc builds.
> Glad to see it's useful elsewhere.

 Thanks for the pointer, and the work you have done to make this more 
robust; it was that that I missed.

> The test retains the old <asm/unistd.h>-based macro extraction for
> testing purposes, but it needs that only for the actual target
> architecture and only the *names*, so it's easy to implement.  Before
> that, the generation would have to carefully take into account multiple
> sub-targets (i386/x86-64/x32 is one of the more complicated scenarios).
> Presumably, you saw problem with that part.

 Yeah, the MIPS o32/n64/n32 ABI set is a corresponding situation, except 
that somewhat longer-lived as we've had support for these three ABIs since 
2001, including the ability to concurrently run user executables built for 
any of these ABIs under a single 64-bit Linux kernel.

  Maciej
