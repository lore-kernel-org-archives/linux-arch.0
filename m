Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23795 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754742AbaAURbx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jan 2014 12:31:53 -0500
Subject: Re: [PATCH v8 3/6] MCS Lock: optimizations and extra comments
From: Tim Chen <tim.c.chen@linux.intel.com>
In-Reply-To: <20140121102626.GV31570@twins.programming.kicks-ass.net>
References: <cover.1390239879.git.tim.c.chen@linux.intel.com>
	 <1390267468.3138.37.camel@schen9-DESK>
	 <20140121102626.GV31570@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Jan 2014 09:31:51 -0800
Message-ID: <1390325511.3138.42.camel@schen9-DESK>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, "Figo.zhang" <figo1802@gmail.com>
Message-ID: <20140121173151.R0dhalfoil-2bHDDHjzKIHExUwu9PDXXEV7wtp-5L14@z>

On Tue, 2014-01-21 at 11:26 +0100, Peter Zijlstra wrote:
> On Mon, Jan 20, 2014 at 05:24:28PM -0800, Tim Chen wrote:
> > From: Jason Low <jason.low2@hp.com>
> > 
> > Remove unnecessary operation to assign locked status to 1 if lock is
> > acquired without contention as this value will not be checked by lock
> > holder again and other potential lock contenders will not be looking at
> > their own lock status.
should be "lock contenders will not be looking at lock holder's 
lock status"

Thanks for catching it.

Tim
> 
> Ha, read that again :-)
> 
> 


