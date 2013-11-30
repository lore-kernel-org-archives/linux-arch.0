From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Sat, 30 Nov 2013 09:38:43 -0800
Message-ID: <20131130173843.GZ4137@linux.vnet.ibm.com>
References: <20131127101613.GC9032@mudshark.cambridge.arm.com>
 <20131127171143.GN4137@linux.vnet.ibm.com>
 <20131128114058.GC21354@mudshark.cambridge.arm.com>
 <20131128173853.GV4137@linux.vnet.ibm.com>
 <20131128180318.GE16203@mudshark.cambridge.arm.com>
 <20131128182712.GW4137@linux.vnet.ibm.com>
 <20131128185341.GG16203@mudshark.cambridge.arm.com>
 <20131128195039.GX4137@linux.vnet.ibm.com>
 <20131129161711.GG31000@mudshark.cambridge.arm.com>
 <CA+55aFwHgnH4h0YwybThQjvicFCVbGbwaAy3Fw0b738gJMtqBA@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwHgnH4h0YwybThQjvicFCVbGbwaAy3Fw0b738gJMtqBA@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, "Figo. zhang" <figo1802@gmail.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Rik van Riel <riel@redhat.com>, Waiman Long <waiman.long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Michel Lespinasse <walken@google.com>, Ingo Molnar <mingo@elte.hu>, Peter Hurley <peter@hurleysoftware.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Alex Shi <alex.shi@linaro.org>, Andrea Arcangeli <aarcange@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 29, 2013 at 08:44:41AM -0800, Linus Torvalds wrote:
> On Nov 29, 2013 8:18 AM, "Will Deacon" <will.deacon@arm.com> wrote:
> >
> >  To get some sort of
> > idea, I tried adding a dmb to the start of spin_unlock on ARMv7 and I saw
> a
> > 3% performance hit in hackbench on my dual-cluster board.
> 
> Don't do a dmb. Just do a dummy release. You just said that on arm64 a
> unlock+lock is a memory barrier, so just make the mb__before_spinlock() be
> a dummy store with release to the stack..
> 
> That should be noticeably cheaper than a full dmb.

Cute!  I like it!  ;-)

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
