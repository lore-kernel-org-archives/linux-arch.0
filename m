Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48959 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042AbaAUKTs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 05:19:48 -0500
Date: Tue, 21 Jan 2014 11:19:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/6] MCS Lock: Move mcs_lock/unlock function into its
 own
Message-ID: <20140121101915.GS31570@twins.programming.kicks-ass.net>
References: <cover.1390239879.git.tim.c.chen@linux.intel.com>
 <1390267471.3138.38.camel@schen9-DESK>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390267471.3138.38.camel@schen9-DESK>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, "Figo.zhang" <figo1802@gmail.com>
Message-ID: <20140121101915.fhkinfA6ca3b4qIng2MSJhxKCfIcCT7VOAGgk-edTzU@z>

On Mon, Jan 20, 2014 at 05:24:31PM -0800, Tim Chen wrote:
> +EXPORT_SYMBOL_GPL(mcs_spin_lock);
> +EXPORT_SYMBOL_GPL(mcs_spin_unlock);

Do we really need the EXPORTs? The only user so far is mutex and that's
core code. The other planned users are rwsems and rwlocks, for both it
would be in the slow path, which is also core code.

We should generally only add EXPORTs once theres a need.
