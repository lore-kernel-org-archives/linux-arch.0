From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 5/6] MCS Lock: allow architectures to hook in to
 contended
Date: Tue, 21 Jan 2014 10:12:11 +0000
Message-ID: <20140121101211.GC30706@mudshark.cambridge.arm.com>
References: <cover.1390239879.git.tim.c.chen@linux.intel.com>
 <1390267475.3138.39.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1390267475.3138.39.camel@schen9-DESK>
Sender: owner-linux-mm@kvack.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>George Spelvin <l>
List-Id: linux-arch.vger.kernel.org

Hi Tim,

On Tue, Jan 21, 2014 at 01:24:35AM +0000, Tim Chen wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> When contended, architectures may be able to reduce the polling overhead
> in ways which aren't expressible using a simple relax() primitive.
> 
> This patch allows architectures to hook into the mcs_{lock,unlock}
> functions for the contended cases only.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

Not a huge problem, but the subject for this patch seem to have been
truncated (should be "... contended paths").

Will

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
