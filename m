From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Sat, 23 Nov 2013 22:29:29 +0100
Message-ID: <20131123212929.GP4971@laptop.programming.kicks-ass.net>
References: <20131122200620.GA4138@linux.vnet.ibm.com>
 <CA+55aFz0nP1_O8jO2UkX1DmDzcBm53-fFejvz=oY=x3cGNBJSQ@mail.gmail.com>
 <20131122203738.GC4138@linux.vnet.ibm.com>
 <CA+55aFwHUuaGzW_=xEWNcyVnHT-zW8-bs6Xi=M458xM3Y1qE0w@mail.gmail.com>
 <20131122215208.GD4138@linux.vnet.ibm.com>
 <CA+55aFzS2yd-VbJB5t14mP8NZG8smB1BQaYCw3Zo19FWQL92vA@mail.gmail.com>
 <20131123002542.GF4138@linux.vnet.ibm.com>
 <CA+55aFy8kx1qaWszc9nrbUaqFu7GfTtDkpzPBeE2g2U6RZjYkA@mail.gmail.com>
 <20131123013654.GG4138@linux.vnet.ibm.com>
 <CA+55aFxQy8afgf6geqJOEHmsJ=ME-6CXrrPfj=aggH7u_jEEZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxQy8afgf6geqJOEHmsJ=ME-6CXrrPfj=aggH7u_jEEZA@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Nov 23, 2013 at 12:21:13PM -0800, Linus Torvalds wrote:
> *SOME* assumption of mine must be wrong. But I don't see which one.

I haven't read your email in full detail yet, but one thing I did miss
was cache-snoops.

One of the reasons for failing transitive / multi-copy atomicity is that
CPUs might have different views of the memory state depending on from
which caches they can get snoops.

Eg. if CPU0 and CPU1 share a cache level but CPU2 does not, CPU1 might
observe a write before CPU2 can.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
