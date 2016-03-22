From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/4] nmi_backtrace: generate one-line reports for idle cpus
Date: Tue, 22 Mar 2016 23:28:03 +0100
Message-ID: <1714182.jSNjvC6qiX@vostro.rjw.lan>
References: <1458667179-19630-1-git-send-email-cmetcalf@mellanox.com> <1458667179-19630-5-git-send-email-cmetcalf@mellanox.com> <20160322173005.GT6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60096 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751484AbcCVWZx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2016 18:25:53 -0400
In-Reply-To: <20160322173005.GT6344@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday, March 22, 2016 06:30:05 PM Peter Zijlstra wrote:
> On Tue, Mar 22, 2016 at 01:19:39PM -0400, Chris Metcalf wrote:
> > When doing an nmi backtrace of many cores, most of which are idle,
> > the output is a little overwhelming and very uninformative.  Suppress
> > messages for cpus that are idling when they are interrupted and just
> > emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> > 
> > We do this by grouping all the cpuidle code together into a new
> > .cpuidle.text section, and then checking the address of the
> > interrupted PC to see if it lies within that section.
> > 
> > This commit suitably tags x86, arm64, and tile idle routines,
> > and only adds in the minimal framework for other architectures.
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> 
> For some reason I found a few CPUs using poll_idle().
> 
> Rafael, when and why would that ever get selected as a useful idle
> state? When the predicted idle time is so short even C1 isn't worth it?

Yes, that's the case.
