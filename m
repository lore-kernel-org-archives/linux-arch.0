Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 19 Mar 2005 04:59:20 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Remove spurious BUG from posix-cpu-timers
Message-ID: <20050319045920.GL21986@parcelfarce.linux.theplanet.co.uk>
References: <20050319044503.GK21986@parcelfarce.linux.theplanet.co.uk> <20050318205334.087395d3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318205334.087395d3.akpm@osdl.org>
Sender: <willy@www.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, Mar 18, 2005 at 08:53:34PM -0800, Andrew Morton wrote:
> Matthew Wilcox <matthew@wil.cx> wrote:
> >
> > 
> > PA-RISC does not necessarily have interrupts disabled while timers are
> > running.  This doesn't appear to be a requirement, but posix-cpu-timers
> > seems to think it is.
> > 
> 
> But a bit later on we do
> 
>         spin_lock(&tsk->sighand->siglock);
> 
> rather than spin_lock_irqsave()?

We're in interrupt context ... we're ok, unless another interrupt handler
tries to take the same spinlock.  Maybe the posix cpu timer code should
be using _irqsave anyway?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
