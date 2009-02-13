From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git pull] sched: do not account for NMIs
Date: Fri, 13 Feb 2009 11:03:19 +0100
Message-ID: <20090213100319.GA1300@elte.hu>
References: <alpine.DEB.1.10.0902121422000.15469@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:60095 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbZBMKEI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Feb 2009 05:04:08 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902121422000.15469@gandalf.stny.rr.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, wli@holomorphy.com, Heiko Carstens <heiko.carstens@de.ibm.com>


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
>       sched: do not account for NMIs
> 
> ----
>  include/linux/hardirq.h |   32 ++++++++++++++++----------------
>  1 files changed, 16 insertions(+), 16 deletions(-)

pulled into tip:tracing/ftrace, thanks Steve!

Btw., any progress on that ia64/etc. build failure related to the NMI
changes? This regression is blocking the linux-next and -mm exposure
of the latest ftrace changes.

	Ingo
