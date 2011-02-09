From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
Date: Wed, 09 Feb 2011 10:37:24 +0100
Message-ID: <1297244244.13327.147.camel@laptop>
References: <1295262433.30950.53.camel@laptop>
         <1297034792.14982.10.camel@pasglop>  <1297086859.13327.16.camel@laptop>
         <1297232054.14982.346.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1297232054.14982.346.camel@pasglop>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm
List-Id: linux-arch.vger.kernel.org

On Wed, 2011-02-09 at 17:14 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2011-02-07 at 14:54 +0100, Peter Zijlstra wrote:
> > On Mon, 2011-02-07 at 10:26 +1100, Benjamin Herrenschmidt wrote:
> > > You missed:
> > > 
> > > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > > index 9813605..467d122 100644
> > > --- a/arch/powerpc/kernel/smp.c
> > > +++ b/arch/powerpc/kernel/smp.c
> > > @@ -98,6 +98,7 @@ void smp_message_recv(int msg)
> > >                 break;
> > >         case PPC_MSG_RESCHEDULE:
> > >                 /* we notice need_resched on exit */
> > > +               scheduler_ipi();
> > >                 break;
> > >         case PPC_MSG_CALL_FUNC_SINGLE:
> > >                 generic_smp_call_function_single_interrupt();
> > > 
> > > Fold that in and add:
> > > 
> > > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Thanks Ben!
> 
> BTW. I we lurking at some of our CPU hotplug code and I think I cannot
> totally guarantee that this won't be called on an offline CPU. If that's
> a problem, you may want to add a test for that.
> 
> IE. The call function IPIs are normally not going to be sent to an
> offlined CPU, and stop_machine should be a good enough fence here, but
> we do abuse reschedule for a number of things (including in some case
> to wake up a sleeping CPU that was pseudo-offlined :-)

Hmm, I _think_ that should all work out nicely, but we'll see, if when
this stuff hits the tree powerpc machines start falling over we'd better
put that check in ;-)

Meanwhile I'm going to preserve this comment in the changelog of this
patch so we don't forget.
