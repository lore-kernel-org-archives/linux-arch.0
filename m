From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 13:14:03 +0200
Message-ID: <20080422111403.GX12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <480DACDD.7040108@qumranet.com> <20080422092230.GW12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080422092230.GW12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

On Tue, Apr 22 2008, Jens Axboe wrote:
> On Tue, Apr 22 2008, Avi Kivity wrote:
> > Jens Axboe wrote:
> > >This adds kernel/smp.c which contains helpers for IPI function calls. In
> > >addition to supporting the existing smp_call_function() in a more efficient
> > >manner, it also adds a more scalable variant called 
> > >smp_call_function_single()
> > >for calling a given function on a single CPU only.
> > >
> > >The core of this is based on the x86-64 patch from Nick Piggin, lots of
> > >changes since then. "Alan D. Brunelle" <Alan.Brunelle-VXdhtT5mjnY@public.gmane.org> has
> > >contributed lots of fixes and suggestions as well.
> > >
> > >+int smp_call_function_single(int cpu, void (*func) (void *info), void 
> > >*info,
> > >+			     int retry, int wait)
> > >+{
> > >+	unsigned long flags;
> > >+	/* prevent preemption and reschedule on another processor */
> > >+	int me = get_cpu();
> > >+	int ret = 0;
> > >+
> > >+	/* Can deadlock when called with interrupts disabled */
> > >+	WARN_ON(wait && irqs_disabled());
> > >+
> > >+	if (cpu == me) {
> > >+		local_irq_save(flags);
> > >+		func(info);
> > >+		local_irq_restore(flags);
> > >+	} else {
> > >+		struct call_single_data d;
> > >+		struct call_single_data *data;
> > >+
> > >+		if (!wait) {
> > >+			data = kmalloc(sizeof(*data), GFP_ATOMIC);
> > >+			if (unlikely(!data)) {
> > >+				ret = -ENOMEM;
> > >+				goto out;
> > >+			}
> > >+			data->flags = CSD_FLAG_ALLOC;
> > >+		} else {
> > >+			data = &d;
> > >+			data->flags = CSD_FLAG_WAIT;
> > >+		}
> > >+
> > >  
> > 
> > Instead of introducing a rare error case, how about falling back to the 
> > wait case if the allocation fails?
> > 
> > Of course, if the called function relies on the calling cpu doing 
> > something else, then this fails, but I don't think anybody would do 
> > that?  On the other hand, there is at least one use of 
> > smp_call_function_single() with !wait, which doesn't check the error return.
> 
> Sure, either failling back to waiting, or add a static call_single_data
> like it exists for smp_call_function(). In reality it'll never happen,
> so the fallback static structure appeals the most to me.

We don't need any extra statically allocated data, we can just reuse the
'csd' element of the existing call_data_fallback. So that is what I did.
Once all archs are converted, we can now change
smp_call_function_single() to a void return, as it always succeeds now.

-- 
Jens Axboe
