From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 3/4] MCS Lock: Barrier corrections
Date: Wed, 06 Nov 2013 14:13:12 -0500
Message-ID: <527A94C8.2020907@hp.com>
References: <cover.1383670202.git.tim.c.chen@linux.intel.com>  <1383673356.11046.279.camel@schen9-DESK>  <20131105183744.GJ26895@mudshark.cambridge.arm.com>  <1383679317.11046.293.camel@schen9-DESK>  <20131105211803.GS28601@twins.programming.kicks-ass.net>  <20131106144520.GK18245@linux.vnet.ibm.com> <1383762133.11046.339.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1383762133.11046.339.camel@schen9-DESK>
Sender: owner-linux-mm@kvack.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zyto>
List-Id: linux-arch.vger.kernel.org

Tim,

I have just sent out a patch as an addendum to your patch series. 
Hopefully that will address the memory barrier issue.

-Longman

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
