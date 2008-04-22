From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
	calls
Date: Tue, 22 Apr 2008 21:12:13 +0200
Message-ID: <20080422191213.GA6370@elte.hu>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804221157220.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804221157220.2779-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, npiggin-l3A5Bk7waGM@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org


* Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:

> 
> [ Ingo added to cc, since this is x86-specific ]
> 
> On Tue, 22 Apr 2008, Jens Axboe wrote:
> > +++ b/arch/x86/kernel/apic_32.c
> > @@ -1357,6 +1357,10 @@ void __init smp_intr_init(void)
> >  
> >  	/* IPI for generic function call */
> >  	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
> > +
> > +	/* IPI for single call function */
> > +	set_intr_gate(CALL_FUNCTION_SINGLE_VECTOR,
> > +				call_function_single_interrupt);
> 
> Ok, one more comment..
> 
> Why bother with separate vectors for this?

this was my first question a month ago when Jens/Nick first submitted it
:)

> Or is it just a performance optimization? [...]

yes and i gave in - Nick and Jens wants to do some crazy stuff and they 
had the numbers. Here's the previous discussion:

  http://lkml.org/lkml/2008/2/27/125

	Ingo
