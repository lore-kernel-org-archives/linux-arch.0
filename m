From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Sun, 27 Apr 2008 12:36:37 +0200
Message-ID: <20080427103637.GV12774@kernel.dk>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-2-git-send-email-jens.axboe@oracle.com> <20080425231100.b93a1601.akpm@linux-foundation.org> <20080427005816.GB21687@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080427005816.GB21687-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

On Sat, Apr 26 2008, Paul E. McKenney wrote:
> On Fri, Apr 25, 2008 at 11:11:00PM -0700, Andrew Morton wrote:
> > > On Tue, 22 Apr 2008 20:50:17 +0200 Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> > > This adds kernel/smp.c which contains helpers for IPI function calls. In
> > > addition to supporting the existing smp_call_function() in a more efficient
> > > manner, it also adds a more scalable variant called smp_call_function_single()
> > > for calling a given function on a single CPU only.
> 
> Where is the new smp_call_function() defined?  I see only the declaration.
> 
> Probably just blind...

kernel/smp.c? Basically just a wrapper around smp_call_function_mask().

> See comments interspersed below.

Thanks a lot! I'll go over these tomorrow, the fallback graceperiod
definitely looks valid.

-- 
Jens Axboe
