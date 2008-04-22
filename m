From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 17:07:56 +0200
Message-ID: <20080422150756.GM12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804220749450.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804220749450.2779-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org

On Tue, Apr 22 2008, Linus Torvalds wrote:
> 
> 
> On Tue, 22 Apr 2008, Linus Torvalds wrote:
> > 
> > You forgot to free the "data" here? The waiter must also free the object, 
> > since now the callee does not.
> 
> Ahh. For the single case, the caller will have it on the stack.

Yes, if wait is set, it's on the stack.

> But the smp_call_function_mask() case seems to leak these things.

Hmm yes, double checking it and it would seem to leak for wait &&
kmalloc'ed data. I think I originally had the wait case as always on
stack, which would explain this leak.

> How about just always doing the "wait" case on the stack? Also, I'd 
> suggest you get rid of the static allocation, and just turn it into a wait 
> case, so that you don't need *three* different allocation cases, just two.

Alright, I'll make 'wait' always alloc on the stack and I'll make
allocation failure turn into 'wait' as well. That'll leave just
kmalloc() and stack allocation, killing the static data fallback.

> Or am I missing something?

No, I think that should work ok. I'll post a new series with the changes
so we can see if we agree.

-- 
Jens Axboe
