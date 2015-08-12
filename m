From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [BELATED CORE TOPIC] context tracking / nohz / RCU state
Date: Wed, 12 Aug 2015 08:59:19 -0700
Message-ID: <20150812155919.GU3895@linux.vnet.ibm.com>
References: <CALCETrW7OiEYFm9FLbC_pnRLMvwb0nTKRWRDMXB3PMc_0H+UoA@mail.gmail.com>
 <20150811183312.GE3895@linux.vnet.ibm.com>
 <20150812143819.GE21542@lerouge>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:59117 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbbHLP70 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2015 11:59:26 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 12 Aug 2015 09:59:25 -0600
Content-Disposition: inline
In-Reply-To: <20150812143819.GE21542@lerouge>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Chris Metcalf <cmetcalf@ezchip.com>, Rik van Riel <riel@redhat.com>, benh@kernel.crashing.org, will.deacon@arm.com, linux-arch@vger.kernel.org

On Wed, Aug 12, 2015 at 04:38:21PM +0200, Frederic Weisbecker wrote:
> On Tue, Aug 11, 2015 at 11:33:12AM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 11, 2015 at 10:49:36AM -0700, Andy Lutomirski wrote:
> > > Some arches may need:
> > > 
> > > i_am_lame_and_forgot_my_previous_context()
> > > 
> > > x86 will soon (4.3 or 4.4, depending on how my syscall cleanup goes)
> > > no longer need that.
> > > 
> > > Paul says that some arches need something that goes straight from IRQ
> > > to user mode (?) -- sigh.
> > 
> > Straight from IRQ to process-level kernel mode.  I ran into this in
> > late 2011, and clearly should have documented exactly what code was
> > doing this.  Something about invoking system calls from within the
> > kernel on some architectures.
> > 
> > Hey, if no architectures do this anymore, I could simplify RCU a bit!  ;-)
> 
> That issue has always been a bit foggy to me :-)
> 
> We never really stated what exactly the issue was. Just performing syscalls
> from kernel mode shouldn't fiddle with the dynticks count.
> 
> IIUC, the issue was that some IRQs triggered and never returned. But we
> certainly can't remove the safety code without clearly identifying the
> issue...

This was not a theoretical problem -- there were real failures.

But yes, the safety code is there and seems to work OK, so I do need
confirmation of a change before removing it.  I do recall someone
arguing that the half-interrupts should go away, but I never did hear
that they really did go away.

Adding linux-arch in the hope that someone can say for sure.

							Thanx, Paul
