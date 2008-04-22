From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function  calls
Date: Tue, 22 Apr 2008 10:52:33 +0200
Message-ID: <20080422085233.GU12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-3-git-send-email-jens.axboe@oracle.com> <20080422084738.GB2388@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080422084738.GB2388-X9Un+BFzKDI@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>

On Tue, Apr 22 2008, Ingo Molnar wrote:
> 
> * Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > This converts x86 and x86-64 to use the new helpers for 
> > smp_call_function() and friends, and adds support for 
> > smp_call_function_single().
> 
> nice stuff. The x86 and generic bits:
> 
>  Acked-by: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>

Thanks, adding...

> this has been brewing for months, what is the testing/confidence status 
> of it? Could we still merge it into v2.6.26? (i think we should)

I'm not aware of any problems. I'd be very grateful if you could give it
a spin on some of your test boxes, just to raise the confidence interval
a bit :-)

-- 
Jens Axboe
