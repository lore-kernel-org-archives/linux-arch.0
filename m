From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 11:39:45 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804221139240.2779@woody.linux-foundation.org>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org> <20080422145105.GJ12774@kernel.dk>
 <alpine.LFD.1.10.0804220759020.2779@woody.linux-foundation.org> <20080422164947.GN12774@kernel.dk> <20080422170405.GO12774@kernel.dk> <20080422171324.GP12774@kernel.dk> <alpine.LFD.1.10.0804221027210.2779@woody.linux-foundation.org>
 <20080422182337.GQ12774@kernel.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422182337.GQ12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org



On Tue, 22 Apr 2008, Jens Axboe wrote:
> 
> OK, so how about this then? All three cases for both
> smp_call_function_single() and smp_call_function_mask(). Data is always
> freed in the ipi interrupt handler, since the 'wait' case is always
> allocated on the stack.

I'm not seeing any obvious bugs any more.

		Linus
