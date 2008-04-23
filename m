From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
 calls
Date: Tue, 22 Apr 2008 18:22:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804221817050.2779@woody.linux-foundation.org>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804221157220.2779@woody.linux-foundation.org> <20080422191213.GA6370@elte.hu> <alpine.LFD.1.10.0804221218410.2779@woody.linux-foundation.org>
 <20080422192601.GB12588@elte.hu> <alpine.LFD.1.10.0804221244350.2779@woody.linux-foundation.org> <20080423011153.GB17572@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080423011153.GB17572-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Cc: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org



On Wed, 23 Apr 2008, Nick Piggin wrote:
> 
> The "too expensive to check the shared queue" is one aspect of it. The
> shared queue need not have events *for us* (at least, unless Jens has
> changed the implementation a bit) but it can still have events that we
> would need to check through.
> 
> I don't think deadlock is a problem (any more than with multiple vectors).

I'm happy with it either way, but as pointed out by Ralf, for the MIPS 
version of the patch there aren't even other vectors available.

So sharing the vector is going to be a requirement on other architectures, 
maybe we should look at whether we can make it generic and peform well 
regardless?

			Linus
