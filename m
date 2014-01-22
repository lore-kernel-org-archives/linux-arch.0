From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v9 5/6] MCS Lock: Order the header files in Kbuild of
 each architecture in alphabetical order
Date: Wed, 22 Jan 2014 09:41:08 -0800
Message-ID: <1390412468.3138.69.camel@schen9-DESK>
References: <cover.1390320729.git.tim.c.chen@linux.intel.com>
	 <1390347376.3138.66.camel@schen9-DESK>
	 <20140122130818.GP31570@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140122130818.GP31570@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin
List-Id: linux-arch.vger.kernel.org

On Wed, 2014-01-22 at 14:08 +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2014 at 03:36:16PM -0800, Tim Chen wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > We perform a clean up of the Kbuid files in each architecture.
> > We order the files in each Kbuild in alphabetical order
> > by running the below script on each Kbuild file:
> > 
> > gawk '/^generic-y/ {
> >         i = 3;
> >         do {
> >                 for (; i<=NF; i++) {
> >                         if ($i == "\\") {
> >                                 getline;
> >                                 i=1;
> >                                 continue;
> >                         }
> >                         if ($i != "")
> >                                 hdr[$i] = $i;
> >                 }
> >                 break;
> >         } while (1);
> >         next;
> > }
> > END {
> >         n = asort(hdr);
> >         for (i=1; i<=n; i++)
> >                 print "generic-y += " hdr[i];
> > }'
> > 
> 
> I'll probably have to regenerate this patch once the merge window is
> done, but that's no biggie.
> 
> sfr, you might want to keep this script handy and distribute to others
> who are lazy and don't want to sort by hand.
> 
> I suppose running it requires a little something like:
> 
> for i in arch/*/include/asm/Kbuild
> do
> 	cat $i | gawk .... > ${i}.sorted;
> 	mv ${i}.sorted $i;
> done

Peter, if this patch and the next one that adds mcs_spinlock.h to
Kbuild looks okay, can you add your signed-off?  Thanks.

Tim


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
