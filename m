Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34307 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfARUof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2019 15:44:35 -0500
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com> <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
In-Reply-To: <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 21:44:16 +0100
Message-ID: <CAK8P3a3bGF9iL6fZyyGS1p6vw56FHNMuosVBShX=MTptb6g4Hw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Firoz Khan <firoz.khan@linaro.org>, alpha <linux-alpha@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <20190118204416.obz7Yka_sN58nPeYdqUPJBB8_Sd7g45P6AdBY6dQP2k@z>

On Fri, Jan 18, 2019 at 8:53 PM Andy Lutomirski <luto@kernel.org> wrote:
> I think we have two issues if we reuse those numbers for new syscalls.
> First, I'd really like to see new syscalls be numbered consistently
> everywhere, or at least on all x86 variants, and we can't on x32
> because they mean something else.  Perhaps more importantly, due to
> what is arguably a rather severe bug, issuing a native x86_64 syscall
> (x32 bit clear) with nr in the range 512..547 does *not* return
> -ENOSYS on a kernel with x32 enabled.  Instead it does something that
> is somewhat arbitrary.  With my patch applied, it will return -ENOSYS,
> but old kernels will still exist, and this will break syscall probing.
>
> Can we perhaps just start the consistent numbers above 547 or maybe
> block out 512..547 in the new regime?

I'm definitely fine with not reusing them ever, and jumping from 511 to
548 when we get there on all architectures, if you think that helps.

While we could also jump to 548 *now*, I think that would be a
bit wasteful. Syscall numbers are fairly cheap, but not entirely
free, especially when you consider architectures like mips that
have an upper bound of 1000 syscalls before they have to get
inventive.

     Arnd
