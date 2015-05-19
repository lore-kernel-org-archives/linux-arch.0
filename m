Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:41608 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbbESCCO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 May 2015 22:02:14 -0400
Message-ID: <1432000931.8339.2.camel@ellerman.id.au>
Subject: Re: [PATCH v2] Documentation/arch: Add kernel feature descriptions
 and arch support status under Documentation/features/
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 19 May 2015 12:02:11 +1000
In-Reply-To: <20150518085423.GA24944@gmail.com>
References: <20150513131835.GJ1517@pd.tnic>
	 <20150513134842.GA1657@gmail.com> <20150513162757.GA21894@x>
	 <20150513150523.ddd65d7cd51f820b78f0c8e3@linux-foundation.org>
	 <20150514101518.GA27550@gmail.com> <20150514103544.GA7027@gmail.com>
	 <20150514123835.1bf436bc35d711f8dbf9bc0f@linux-foundation.org>
	 <1431644248.2981.1.camel@ellerman.id.au> <20150515074949.GB14993@gmail.com>
	 <1431913033.13218.2.camel@ellerman.id.au>
	 <20150518085423.GA24944@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150519020211.udnM5He1NwQKr5TW6qcwWb0RtoQq997xeD9BnMi4gq0@z>

On Mon, 2015-05-18 at 10:54 +0200, Ingo Molnar wrote:
> * Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > > > Yes it is. I have my own version I've cobbled together for 
> > > > powerpc, but this is much better.
> > > 
> > > Please double check the PowerPC support matrix for correctness (if 
> > > you haven't yet):
> > 
> > It looks good except for:
> > 
> > >        rwsem-optimized:  |  ok  |                              Optimized asm/rwsem.h #  arch provides optimized rwsem APIs
> > 
> > I don't see an rwsem.h in powerpc anywhere?
> 
> Indeed, that slipped through. I fixed it to:
> 
>     triton:~/tip> cat Documentation/features/locking/rwsem-optimized/arch-support.txt 
>     #
>     # Feature name:          rwsem-optimized
>     #         Kconfig:       Optimized asm/rwsem.h
>     #         description:   arch provides optimized rwsem APIs
>     #
>         |     powerpc: | TODO |
> 
>     triton:~/tip> cat Documentation/features/time/irq-time-acct/arch-support.txt
>     #
>     # Feature name:          irq-time-acct
>     #         Kconfig:       HAVE_IRQ_TIME_ACCOUNTING
>     #         description:   arch supports precise IRQ time accounting
>     #
>         |     powerpc: |  ..  |
> 
> i.e. it's not marked as TODO, but not as supported either which would 
> be misleading.

Great thanks.

cheers


