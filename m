From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
 calls
Date: Tue, 22 Apr 2008 12:22:32 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804221218410.2779@woody.linux-foundation.org>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804221157220.2779@woody.linux-foundation.org> <20080422191213.GA6370@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422191213.GA6370-X9Un+BFzKDI@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, npiggin-l3A5Bk7waGM@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org



On Tue, 22 Apr 2008, Ingo Molnar wrote:
> 
> > Or is it just a performance optimization? [...]
> 
> yes and i gave in - Nick and Jens wants to do some crazy stuff and they 
> had the numbers. Here's the previous discussion:
> 
>   http://lkml.org/lkml/2008/2/27/125

No, the previous discussion was about single *queues* vs single *vectors*.

I agree unconditionally with the decision to use a separate per-cpu queue 
from the shared queue (in fact, I would argue that the "mask" code might 
want to notice when the mask is just a single CPU, and turn a mask request 
into a targeted request). 

But I wonder why we want to then have two IPI target vectors, when it 
would appear to be perfectly fine and cheap to have just a single vector 
that can handle both the per-cpu case and the shared queue case (since the 
thing would tend to be one or the other, not both).

A single vector is still pefectly fine, if 99% of all usage cases are the 
targeted-to-a-single-cpu thing, because the shared queue will basically be 
empty (and you can test that without even taking any locks).

		Linus
