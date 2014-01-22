Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37358 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbaAVSgZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2014 13:36:25 -0500
Date: Wed, 22 Jan 2014 19:35:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 6/6] MCS Lock: Allow architecture specific asm files
 to be used for contended case
Message-ID: <20140122183539.GM30183@twins.programming.kicks-ass.net>
References: <cover.1390320729.git.tim.c.chen@linux.intel.com>
 <1390347382.3138.67.camel@schen9-DESK>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390347382.3138.67.camel@schen9-DESK>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, "Figo.zhang" <figo1802@gmail.com>
Message-ID: <20140122183539.uoG_Flkp-IS3lWqwATqtWBajF1Xwuzaimn8zQAG7UAA@z>

On Tue, Jan 21, 2014 at 03:36:22PM -0800, Tim Chen wrote:
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index 8b19a80..24027ce 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -1,6 +1,8 @@
>  
> +generic-y += +=
>  generic-y += clkdev.h
> +generic-y += mcs_spinlock.h
>  generic-y += preempt.h
>  generic-y += rwsem.h
>  generic-y += trace_clock.h
> -generic-y += vtime.h
> +generic-y += vtime.hgeneric-y

Something went funny there, fixed it.
