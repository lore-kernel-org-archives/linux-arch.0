From: Julia Lawall <julia@diku.dk>
Subject: Re: Lots of bugs with current->state = TASK_*INTERRUPTIBLE
Date: Thu, 21 Jan 2010 11:47:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001211145480.13529@ask.diku.dk>
References: <1263932978.31321.53.camel@gandalf.stny.rr.com>
 <Pine.LNX.4.64.1001192155490.28583@ask.diku.dk> <1263935333.4561.26.camel@frodo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755211Ab0AUKrq@vger.kernel.org>
In-Reply-To: <1263935333.4561.26.camel@frodo>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>, Andy Whitcroft <apw@canonical.com>
List-Id: linux-arch.vger.kernel.org

What about something like the following (drivers/macintosh/adb.c):

        add_wait_queue(&state->wait_queue, &wait);
        current->state = TASK_INTERRUPTIBLE;

	for (;;) {
	        req = state->completed;
                if (req != NULL)
                        state->completed = req->next;
                else if (atomic_read(&state->n_pending) == 0)
                        ret = -EIO;
		if (req != NULL || ret != 0)
			break;

                if (file->f_flags & O_NONBLOCK) {
                        ret = -EAGAIN;
                        break;
		}
                if (signal_pending(current)) {
                        ret = -ERESTARTSYS;
                        break;
                }
                spin_unlock_irqrestore(&state->lock, flags);
                schedule();
        	spin_lock_irqsave(&state->lock, flags);
        }

        current->state = TASK_RUNNING;
        remove_wait_queue(&state->wait_queue, &wait);

There is a call to schedule eventually after the first current->state 
assignment, but it is not right after.

thanks,
julia
