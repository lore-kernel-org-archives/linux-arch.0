From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git pull] preempt-count: force hardirq-count to max of 10
Date: Fri, 13 Feb 2009 12:58:51 +0100
Message-ID: <20090213115851.GK15679@elte.hu>
References: <alpine.DEB.1.10.0902121139230.15469@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902121139230.15469@gandalf.stny.rr.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, kernel@avr32linux.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Mike Travis <travis@sgi.com>, isimatu.yasuaki@jp.fujitsu.com
List-Id: linux-arch.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> Please pull the latest tip/tracing/core tree, which can be found at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
> tip/tracing/core
> 
> 
> Steven Rostedt (1):
>       preempt-count: force hardirq-count to max of 10
> 
> ----
>  arch/alpha/include/asm/hardirq.h |   13 ----------
>  arch/avr32/include/asm/hardirq.h |   11 --------
>  arch/ia64/include/asm/hardirq.h  |   10 --------
>  include/linux/hardirq.h          |   48 +++++++++++++++++++-------------------
>  4 files changed, 24 insertions(+), 58 deletions(-)

Pulled, thanks Steve.

	Ingo
