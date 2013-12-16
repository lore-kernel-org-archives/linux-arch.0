From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] arch: Introduce smp_load_acquire(),
 smp_store_release()
Date: Mon, 16 Dec 2013 13:37:20 -0800
Message-ID: <20131216213720.GA28557@linux.vnet.ibm.com>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.908486364@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:57752 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab3LPVh2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2013 16:37:28 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 16 Dec 2013 14:37:28 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BD55419D804E
	for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2013 14:37:18 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBGLbOef64159902
	for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2013 22:37:24 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id rBGLeQke026845
	for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2013 14:40:30 -0700
Content-Disposition: inline
In-Reply-To: <20131213150640.908486364@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kerne.org, geert@linux-m68k.org, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com, Will Deacon <will.deacon@arm.com>

On Fri, Dec 13, 2013 at 03:57:01PM +0100, Peter Zijlstra wrote:
> A number of situations currently require the heavyweight smp_mb(),
> even though there is no need to order prior stores against later
> loads.  Many architectures have much cheaper ways to handle these
> situations, but the Linux kernel currently has no portable way
> to make use of them.
> 
> This commit therefore supplies smp_load_acquire() and
> smp_store_release() to remedy this situation.  The new
> smp_load_acquire() primitive orders the specified load against
> any subsequent reads or writes, while the new smp_store_release()
> primitive orders the specifed store against any prior reads or
> writes.  These primitives allow array-based circular FIFOs to be
> implemented without an smp_mb(), and also allow a theoretical
> hole in rcu_assign_pointer() to be closed at no additional
> expense on most architectures.
> 
> In addition, the RCU experience transitioning from explicit
> smp_read_barrier_depends() and smp_wmb() to rcu_dereference()
> and rcu_assign_pointer(), respectively resulted in substantial
> improvements in readability.  It therefore seems likely that
> replacing other explicit barriers with smp_load_acquire() and
> smp_store_release() will provide similar benefits.  It appears
> that roughly half of the explicit barriers in core kernel code
> might be so replaced.

And here is an RFC patch switching rcu_assign_pointer() from
smp_wmb() to smp_store_release().  Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

rcu: Define rcu_assign_pointer() in terms of smp_store_release()

The new smp_store_release() function provides better guarantees than did
rcu_assign_pointer(), and potentially less overhead on some architectures.
The guarantee that smp_store_release() provides that rcu_assign_pointer()
does that is obscure, but its lack could cause considerable confusion.
This guarantee is illustrated by the following code fragment:
    
    	struct foo {
    		int a;
    		int b;
    		int c;
    		struct foo *next;
    	};
    	struct foo foo1;
    	struct foo foo2;
    	struct foo __rcu *foop;
    
    	...
    
    	foo2.a = 1;
    	foo2.b = 2;
    	BUG_ON(foo2.c);
    	rcu_assign_pointer(foop, &foo);
    
    	...
    
    	fp = rcu_dereference(foop);
    	fp.c = 3;

The current rcu_assign_pointer() semantics permit the BUG_ON() to
trigger because rcu_assign_pointer()'s smp_wmb() is not guaranteed to
order prior reads against later writes.  This commit therefore upgrades
rcu_assign_pointer() from smp_wmb() to smp_store_release() to avoid this
counter-intuitive outcome.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index ad5258cc051b..2fe509171e21 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -582,11 +582,7 @@ static inline void rcu_preempt_sleep_check(void)
  * please be careful when making changes to rcu_assign_pointer() and the
  * other macros that it invokes.
  */
-#define rcu_assign_pointer(p, v) \
-	do { \
-		smp_wmb(); \
-		ACCESS_ONCE(p) = RCU_INITIALIZER(v); \
-	} while (0)
+#define rcu_assign_pointer(p, v) smp_store_release(&p, RCU_INITIALIZER(v));
 
 
 /**
