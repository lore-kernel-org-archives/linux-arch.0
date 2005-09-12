Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 12 Sep 2005 11:27:10 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: spinlock-consolidation.patch
Message-ID: <20050912092710.GB5731@elte.hu>
References: <20050909121521.12942a8d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909121521.12942a8d.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>


* Andrew Morton <akpm@osdl.org> wrote:

> Guys, I'm planning on sending this Linuswards in about two days time.  
> There's never a right time for this sort of thing and there may be 
> some relatively trivial breakage for architectures I don't test for.  
> But it kills 1300 lines of code.

the patch goes far beyond code reduction effects: the patch also unifies 
and centralizes all known spinlock-debugging features, which improves 
every architecture. E.g. on x86 we can now detect spinlock deadlocks 
even without the NMI watchdog. Even the architecture with the most 
advanced lowlevel spinlock-debugging framework (Sparc) gets improved a 
bit by this [by getting additional rwlock debugging code].

If i missed any spinlock-debugging cleverness then please holler and 
i'll add it to the generic code.

	Ingo

ps. also, with this patch the ATOMIC_DEC_AND_LOCK uglinesses have 
    finally become history

ps2. and PREEMPT_RT gets a central spinlock type to fiddle with ;-)
