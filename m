From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 16:51:06 +0200
Message-ID: <20080422145105.GJ12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804220735350.2779-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org

On Tue, Apr 22 2008, Linus Torvalds wrote:
> 
> 
> On Tue, 22 Apr 2008, Jens Axboe wrote:
> > +
> > +static inline void csd_flag_wait(struct call_single_data *data)
> > +{
> > +	/* Wait for response */
> > +	do {
> > +		/*
> > +		 * We need to see the flags store in the IPI handler
> > +		 */
> > +		smp_mb();
> > +		if (!(data->flags & CSD_FLAG_WAIT))
> > +			break;
> > +		cpu_relax();
> > +	} while (1);
> > +}
> 
> You forgot to free the "data" here? The waiter must also free the object, 
> since now the callee does not.

The ipi interrupt handler does that, see kfree() in
generic_smp_call_function_single_interrupt() or call_func_data_free() in
generic_smp_call_function_interrupt().

-- 
Jens Axboe
