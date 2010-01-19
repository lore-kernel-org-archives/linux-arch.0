From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Lots of bugs with current->state = TASK_*INTERRUPTIBLE
Date: Tue, 19 Jan 2010 16:08:53 -0500
Message-ID: <1263935333.4561.26.camel@frodo>
References: <1263932978.31321.53.camel@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.1001192155490.28583@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:47153 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab0ASVKo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2010 16:10:44 -0500
In-Reply-To: <Pine.LNX.4.64.1001192155490.28583@ask.diku.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>, Andy Whitcroft <apw@canonical.com>

On Tue, 2010-01-19 at 21:58 +0100, Julia Lawall wrote:
> > Anyway, this looks like a good janitorial work. Anything that assigns
> > state outside the rq locks to something other than TASK_RUNNING and that
> > is not before a schedule() (perhaps even those) should be converted to:
> > 
> > 	set_current_task(<state>).
> 
> Does "not before a schedule" mean not before a schedule_timeout as well?

Yep.

> 
> Also, I assume you mean set_current_state?

Yep!

Thanks!

-- Steve
