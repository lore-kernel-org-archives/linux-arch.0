From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Thu, 21 Nov 2013 05:16:54 -0800
Message-ID: <20131121131654.GP4138@linux.vnet.ibm.com>
References: <20131120153123.GF4138@linux.vnet.ibm.com>
 <20131120154643.GG19352@mudshark.cambridge.arm.com>
 <20131120171400.GI4138@linux.vnet.ibm.com>
 <1384973026.11046.465.camel@schen9-DESK>
 <20131120190616.GL4138@linux.vnet.ibm.com>
 <1384979767.11046.489.camel@schen9-DESK>
 <20131120214402.GM4138@linux.vnet.ibm.com>
 <1384991514.11046.504.camel@schen9-DESK>
 <20131121045333.GO4138@linux.vnet.ibm.com>
 <20131121101736.GA13067@mudshark.cambridge.arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131121101736.GA13067@mudshark.cambridge.arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 21, 2013 at 10:17:36AM +0000, Will Deacon wrote:
> On Thu, Nov 21, 2013 at 04:53:33AM +0000, Paul E. McKenney wrote:
> > On Wed, Nov 20, 2013 at 03:51:54PM -0800, Tim Chen wrote:
> > > If we intend to use smp_load_acquire and smp_store_release extensively
> > > for locks, making RCsc semantics the default will simply things a lot.
> > 
> > The other option is to weaken lock semantics so that unlock-lock no
> > longer implies a full barrier, but I believe that we would regret taking
> > that path.  (It would be OK by me, I would just add a few smp_mb()
> > calls on various slowpaths in RCU.  But...)
> 
> Unsurprisingly, my vote is for RCsc semantics.

That was in fact my guess.  ;-)

> One major advantage (in my opinion) of the acquire/release accessors is that
> they feel intuitive in an area where intuition is hardly rife. I believe
> that the additional reordering permitted by RCpc detracts from the relative
> simplicity of what is currently being proposed.

Fair point!  Let's see what others (both hackers and architectures) say.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
