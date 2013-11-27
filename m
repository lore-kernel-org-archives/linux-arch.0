From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Tue, 26 Nov 2013 17:07:49 -0800
Message-ID: <CA+55aFygj=JQkFf7-tW4CxXsECqYqxVeDva4gvBttu75-x0dOQ@mail.gmail.com>
References: <20131121132041.GS4138@linux.vnet.ibm.com>
	<20131121172558.GA27927@linux.vnet.ibm.com>
	<20131121215249.GZ16796@laptop.programming.kicks-ass.net>
	<20131121221859.GH4138@linux.vnet.ibm.com>
	<20131122155835.GR3866@twins.programming.kicks-ass.net>
	<20131122182632.GW4138@linux.vnet.ibm.com>
	<20131122185107.GJ4971@laptop.programming.kicks-ass.net>
	<20131125173540.GK3694@twins.programming.kicks-ass.net>
	<20131125180250.GR4138@linux.vnet.ibm.com>
	<5293E37F.5020908@zytor.com>
	<20131126031626.GE4138@linux.vnet.ibm.com>
	<529540FE.3070504@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <529540FE.3070504@zytor.com>
Sender: owner-linux-mm@kvack.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@h>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 26, 2013 at 4:46 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> The best pointer I can give is the example in section 8.2.3.6 of the
> current SDM (version 048, dated September 2013).  It is a bit more
> complex than what you have described above.

That 8.2.3.6 thing (and the whole "causally related" argument) does
seem to say that the MCS lock is fine on x86 without any extra
barriers. My A < B .. < F < A argument was very much a causality-based
one.

          Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
