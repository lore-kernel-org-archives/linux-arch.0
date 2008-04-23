From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Wed, 23 Apr 2008 08:07:26 +0200
Message-ID: <20080423060725.GT12774@kernel.dk>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-2-git-send-email-jens.axboe@oracle.com> <1208895423.7115.290.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1208895423.7115.290.camel@twins>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

On Tue, Apr 22 2008, Peter Zijlstra wrote:
> On Tue, 2008-04-22 at 20:50 +0200, Jens Axboe wrote:
> 
> > +int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
> > +			     int retry, int wait)
> > +{
> > +	unsigned long flags;
> > +	/* prevent preemption and reschedule on another processor */
> > +	int me = get_cpu();
> > +
> > +	/* Can deadlock when called with interrupts disabled */
> > +	WARN_ON(wait && irqs_disabled());
> 
> With this fallback to wait the above condition isn't sufficient.

What deadlock are you concerned with here? Would making cfd_fallback
per-cpu make you feel better?

-- 
Jens Axboe
