From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 5/5] MCS Lock: Allow architecture specific memory
 barrier in lock/unlock
Date: Thu, 7 Nov 2013 08:40:38 +0100
Message-ID: <20131107074038.GB26654@gmail.com>
References: <cover.1383783691.git.tim.c.chen@linux.intel.com>
 <1383787620.11046.368.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1383787620.11046.368.camel@schen9-DESK>
Sender: owner-linux-mm@kvack.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin
List-Id: linux-arch.vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> This patch moves the decision of what kind of memory barriers to be
> used in the MCS lock and unlock functions to the architecture specific
> layer. It also moves the actual lock/unlock code to mcs_spinlock.c
> file.
> 
> A full memory barrier will be used if the following macros are not
> defined:
>  1) smp_mb__before_critical_section()
>  2) smp_mb__after_critical_section()
> 
> For the x86 architecture, only compiler barrier will be needed.
> 
> Acked-by: Tim Chen <tim.c.chen@linux.intel.com>

This should be Signed-off-by and should come last in the SOB chain, as you 
are the person passing the patch along.

> Signed-off-by: Waiman Long <Waiman.Long@hp.com>

I think you lost a:

  From: Waiman Long <Waiman.Long@hp.com>

from the beginning of the mail, because right now if your patch is applied 
it will credit you with being the author - that wasn't the intention, 
right?

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
