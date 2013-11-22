From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Thu, 21 Nov 2013 20:25:59 -0800
Message-ID: <CA+55aFxSL96G_uuPSbJaXfGh7DpYZ1g0NcVfPKOFg1O0o0fyZg@mail.gmail.com>
References: <20131120171400.GI4138@linux.vnet.ibm.com>
	<1384973026.11046.465.camel@schen9-DESK>
	<20131120190616.GL4138@linux.vnet.ibm.com>
	<1384979767.11046.489.camel@schen9-DESK>
	<20131120214402.GM4138@linux.vnet.ibm.com>
	<1384991514.11046.504.camel@schen9-DESK>
	<20131121045333.GO4138@linux.vnet.ibm.com>
	<CA+55aFyXzDUss55SjQBy+C-neRZbVsmVRR4aat+wiWfuSQJxaQ@mail.gmail.com>
	<20131121225208.GJ4138@linux.vnet.ibm.com>
	<CA+55aFx3FSGAtdSTYmsZ8xtdpiSBM-XPSnxnMpRQY+S_v_72-g@mail.gmail.com>
	<20131122040856.GK4138@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20131122040856.GK4138@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.c>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 21, 2013 at 8:08 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> It is not the architecture that matters here, it is just a definition of
> what ordering guarantees the locking primitives provide, independent of
> the architecture.

So we definitely come from very different backgrounds.

I don't care one *whit* about theoretical lock orderings. Not a bit.

I do care deeply about reality, particularly of architectures that
actually matter. To me, a spinlock in some theoretical case is
uninteresting, but a efficient spinlock implementation on a real
architecture is a big deal that matters a lot.

              Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
