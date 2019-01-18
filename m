Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729375AbfARTxj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Jan 2019 14:53:39 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526192173C
        for <linux-arch@vger.kernel.org>; Fri, 18 Jan 2019 19:53:38 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id s12so16524566wrt.4
        for <linux-arch@vger.kernel.org>; Fri, 18 Jan 2019 11:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com> <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
In-Reply-To: <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 18 Jan 2019 11:53:25 -0800
Message-ID: <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Firoz Khan <firoz.khan@linaro.org>, alpha <linux-alpha@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <20190118195325.n1czN1qLkI-ll_6ZZQJIP16fKWwEUxsDpKeLtzItxW8@z>

On Fri, Jan 18, 2019 at 11:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> > On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > - Once we get to 512, we clash with the x32 numbers (unless
> > >   we remove x32 support first), and probably have to skip
> > >   a few more. I also considered using the 512..547 space
> > >   for 32-bit-only calls (which never clash with x32), but
> > >   that also seems to add a bit of complexity.
> >
> > I have a patch that I'll send soon to make x32 use its own table.  As
> > far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> > not special.  But let's please not reuse 512..547 for other purposes
> > on x86 variants -- that way lies even more confusion, IMO.
>
> Fair enough, the space for those numbers is cheap enough here.
> I take it you mean we also should not reuse that number space if
> we were to decide to remove x32 soon, but you are not worried
> about clashing with arch/alpha when everything else uses consistent
> numbers?
>

I think we have two issues if we reuse those numbers for new syscalls.
First, I'd really like to see new syscalls be numbered consistently
everywhere, or at least on all x86 variants, and we can't on x32
because they mean something else.  Perhaps more importantly, due to
what is arguably a rather severe bug, issuing a native x86_64 syscall
(x32 bit clear) with nr in the range 512..547 does *not* return
-ENOSYS on a kernel with x32 enabled.  Instead it does something that
is somewhat arbitrary.  With my patch applied, it will return -ENOSYS,
but old kernels will still exist, and this will break syscall probing.

Can we perhaps just start the consistent numbers above 547 or maybe
block out 512..547 in the new regime?

--Andy
