From: Julia Lawall <julia@diku.dk>
Subject: Re: Lots of bugs with current->state = TASK_*INTERRUPTIBLE
Date: Tue, 19 Jan 2010 21:58:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001192155490.28583@ask.diku.dk>
References: <1263932978.31321.53.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755433Ab0ASU6c@vger.kernel.org>
In-Reply-To: <1263932978.31321.53.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>, Andy Whitcroft <apw@canonical.com>
List-Id: linux-arch.vger.kernel.org

> Anyway, this looks like a good janitorial work. Anything that assigns
> state outside the rq locks to something other than TASK_RUNNING and that
> is not before a schedule() (perhaps even those) should be converted to:
> 
> 	set_current_task(<state>).

Does "not before a schedule" mean not before a schedule_timeout as well?

Also, I assume you mean set_current_state?

julia
