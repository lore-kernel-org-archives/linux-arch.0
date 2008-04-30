From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/10] Add generic helpers for arch IPI function calls
Date: Wed, 30 Apr 2008 13:34:57 +0200
Message-ID: <20080430113456.GY12774@kernel.dk>
References: <1209453990-7735-1-git-send-email-jens.axboe@oracle.com> <1209453990-7735-2-git-send-email-jens.axboe@oracle.com> <20080429135936.GC12390@linux.vnet.ibm.com> <20080430112934.GA23203@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080430112934.GA23203-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy-TSDbQ3PG+2Y@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org

On Wed, Apr 30 2008, Paul E. McKenney wrote:
> On Tue, Apr 29, 2008 at 06:59:36AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 29, 2008 at 09:26:21AM +0200, Jens Axboe wrote:
> > > This adds kernel/smp.c which contains helpers for IPI function calls. In
> > > addition to supporting the existing smp_call_function() in a more efficient
> > > manner, it also adds a more scalable variant called smp_call_function_single()
> > > for calling a given function on a single CPU only.
> > > 
> > > The core of this is based on the x86-64 patch from Nick Piggin, lots of
> > > changes since then. "Alan D. Brunelle" <Alan.Brunelle-VXdhtT5mjnY@public.gmane.org> has
> > > contributed lots of fixes and suggestions as well.
> > 
> > Looks much better, but there still appears to be a potential deadlock
> > with a CPU spinning waiting (indirectly) for a grace period to complete.
> > Such spinning can prevent the grace period from ever completing.
> > 
> > See "!!!".
> 
> One additional question...  Why not handle memory allocation failure
> by pretending that the caller to smp_call_function() had specified
> "wait"?  The callee is in irq context, so cannot block, right?

(BTW a lot of thanks for your comments, I've read and understood most of
it, I'll reply in due time - perhaps not until next week, I'll be gone
from this afternoon and until monday).

We cannot always fallback to wait, unfortunately. If irqs are disabled,
you could deadlock between two CPUs each waiting for each others IPI
ack.

So the good question is how to handle the problem. The easiest would be
to return ENOMEM and get rid of the fallback, but the fallback deadlocks
are so far mostly in the theoretical realm since it PROBABLY would not
occur in practice. But still no good enough, so I'm still toying with
ideas on how to make it 100% bullet proof.

-- 
Jens Axboe
