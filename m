Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38651 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbERIya (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 May 2015 04:54:30 -0400
Date: Mon, 18 May 2015 10:54:23 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] Documentation/arch: Add kernel feature descriptions
 and arch support status under Documentation/features/
Message-ID: <20150518085423.GA24944@gmail.com>
References: <20150513131835.GJ1517@pd.tnic>
 <20150513134842.GA1657@gmail.com>
 <20150513162757.GA21894@x>
 <20150513150523.ddd65d7cd51f820b78f0c8e3@linux-foundation.org>
 <20150514101518.GA27550@gmail.com>
 <20150514103544.GA7027@gmail.com>
 <20150514123835.1bf436bc35d711f8dbf9bc0f@linux-foundation.org>
 <1431644248.2981.1.camel@ellerman.id.au>
 <20150515074949.GB14993@gmail.com>
 <1431913033.13218.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431913033.13218.2.camel@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150518085423.WHAE3hejlqGFATDw7xp0OElgZCeiOLyXmHrHN1IMkE8@z>


* Michael Ellerman <mpe@ellerman.id.au> wrote:

> > > Yes it is. I have my own version I've cobbled together for 
> > > powerpc, but this is much better.
> > 
> > Please double check the PowerPC support matrix for correctness (if 
> > you haven't yet):
> 
> It looks good except for:
> 
> >        rwsem-optimized:  |  ok  |                              Optimized asm/rwsem.h #  arch provides optimized rwsem APIs
> 
> I don't see an rwsem.h in powerpc anywhere?

Indeed, that slipped through. I fixed it to:

    triton:~/tip> cat Documentation/features/locking/rwsem-optimized/arch-support.txt 
    #
    # Feature name:          rwsem-optimized
    #         Kconfig:       Optimized asm/rwsem.h
    #         description:   arch provides optimized rwsem APIs
    #
        -----------------------
        |         arch |status|
        -----------------------
        |       alpha: |  ok  |
        |         arc: | TODO |
        |         arm: | TODO |
        |       arm64: | TODO |
        |       avr32: | TODO |
        |    blackfin: | TODO |
        |         c6x: | TODO |
        |        cris: | TODO |
        |         frv: | TODO |
        |     hexagon: | TODO |
        |        ia64: |  ok  |
        |        m32r: | TODO |
        |        m68k: | TODO |
        |       metag: | TODO |
        |  microblaze: | TODO |
        |        mips: | TODO |
        |     mn10300: | TODO |
        |       nios2: | TODO |
        |    openrisc: | TODO |
        |      parisc: | TODO |
        |     powerpc: | TODO |
        |        s390: |  ok  |
        |       score: | TODO |
        |          sh: |  ok  |
        |       sparc: |  ok  |
        |        tile: | TODO |
        |          um: | TODO |
        |   unicore32: | TODO |
        |         x86: |  ok  |
        |      xtensa: |  ok  |
        -----------------------

> And this is correct but a bit confusing:
> 
> >          irq-time-acct:  |  ok  |                           HAVE_IRQ_TIME_ACCOUNTING #  arch supports precise IRQ time accounting
> 
> I think you and Paul agreed it's "ok" on powerpc because we have
> VIRT_CPU_ACCOUNTING instead, but that's not obvious.

Ok, so I modified it to print '..' instead:

    triton:~/tip> cat Documentation/features/time/irq-time-acct/arch-support.txt
    #
    # Feature name:          irq-time-acct
    #         Kconfig:       HAVE_IRQ_TIME_ACCOUNTING
    #         description:   arch supports precise IRQ time accounting
    #
        -----------------------
        |         arch |status|
        -----------------------
        |       alpha: |  ..  |
        |         arc: | TODO |
        |         arm: |  ok  |
        |       arm64: |  ..  |
        |       avr32: | TODO |
        |    blackfin: | TODO |
        |         c6x: | TODO |
        |        cris: | TODO |
        |         frv: | TODO |
        |     hexagon: | TODO |
        |        ia64: |  ..  |
        |        m32r: | TODO |
        |        m68k: | TODO |
        |       metag: | TODO |
        |  microblaze: | TODO |
        |        mips: |  ok  |
        |     mn10300: | TODO |
        |       nios2: | TODO |
        |    openrisc: | TODO |
        |      parisc: |  ..  |
        |     powerpc: |  ..  |
        |        s390: |  ..  |
        |       score: | TODO |
        |          sh: | TODO |
        |       sparc: |  ..  |
        |        tile: |  ..  |
        |          um: | TODO |
        |   unicore32: | TODO |
        |         x86: |  ok  |
        |      xtensa: |  ok  |
        -----------------------

i.e. it's not marked as TODO, but not as supported either which would 
be misleading.

Thanks,

	Ingo
