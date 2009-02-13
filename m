From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git pull] sched: do not account for NMIs
Date: Fri, 13 Feb 2009 12:57:44 +0100
Message-ID: <20090213115744.GA3771@elte.hu>
References: <alpine.DEB.1.10.0902121422000.15469@gandalf.stny.rr.com> <20090213100319.GA1300@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:46149 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbZBML7N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Feb 2009 06:59:13 -0500
Content-Disposition: inline
In-Reply-To: <20090213100319.GA1300@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, wli@holomorphy.com, Heiko Carstens <heiko.carstens@de.ibm.com>


* Ingo Molnar <mingo@elte.hu> wrote:

> Btw., any progress on that ia64/etc. build failure related to the
> NMI changes? 

ah, disregard this - you already sent the fix for that.

	Ingo
