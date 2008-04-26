From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Sat, 26 Apr 2008 10:04:15 +0200
Message-ID: <20080426080415.GB3891@ucw.cz>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <480E70ED.3030701@rtr.ca> <20080423072432.GX12774@kernel.dk> <480F3CBC.60305@rtr.ca> <20080423135110.GO12774@kernel.dk> <480F4BD9.8090003@rtr.ca> <20080424105908.GW12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080424105908.GW12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Mark Lord <lkml-gsilrlXbHYg@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

Hi!

> > >>The second bug, is that for the halt case at least,
> > >>nobody waits for the other CPU to actually halt
> > >>before continuing.. so we sometimes enter the shutdown
> > >>code while other CPUs are still active.
> > >>
> > >>This causes some machines to hang at shutdown,
> > >>unless CPU_HOTPLUG is configured and takes them offline
> > >>before we get here.
> > >
> > >I'm guessing there's a reason it doesn't pass '1' as the last argument,
> > >because that would fix that issue?
> > 
> > Undoubtedly -- perhaps the called CPU halts, and therefore cannot reply.  :)
> 
> Uhm yes, I guess stop_this_cpu() does exactly what the name implies :-)
> 
> > But some kind of pre-halt ack, perhaps plus a short delay by the caller
> > after receipt of the ack, would probably suffice to kill that bug.
> > 
> > But I really haven't studied this code enough to know,
> > other than that it historically has been a sticky area
> > to poke around in.
> 
> Something like this will close the window to right up until the point
> where the other CPUs have 'almost' called halt().

Now I took a look at context... why not simply use same trick swsusp
uses, and do a hot unplug of all cpus at the end of shutdown?

> 
> diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> index 5398385..94ec9bf 100644
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -155,8 +155,9 @@ static void stop_this_cpu(void *dummy)
>  	/*
>  	 * Remove this CPU:
>  	 */
> -	cpu_clear(smp_processor_id(), cpu_online_map);
>  	disable_local_APIC();
> +	cpu_clear(smp_processor_id(), cpu_online_map);
> +	smp_wmb();
>  	if (hlt_works(smp_processor_id()))
>  		for (;;) halt();
>  	for (;;);
> @@ -175,6 +176,12 @@ static void native_smp_send_stop(void)
>  
>  	local_irq_save(flags);
>  	smp_call_function(stop_this_cpu, NULL, 0, 0);
> +
> +	while (cpus_weight(cpu_online_map) > 1) {
> +		cpu_relax();
> +		smp_rmb();
> +	}
> +
>  	disable_local_APIC();
>  	local_irq_restore(flags);
>  }


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
