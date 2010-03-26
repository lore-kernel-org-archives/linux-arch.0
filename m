From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU read lock vs spinlocks
Date: Fri, 26 Mar 2010 09:39:11 -0700
Message-ID: <20100326163911.GD2343@linux.vnet.ibm.com>
References: <29095.1269514315@redhat.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:36022 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab0CZQjQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 12:39:16 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2QGSPNG019774
	for <linux-arch@vger.kernel.org>; Fri, 26 Mar 2010 12:28:25 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o2QGdFPT179752
	for <linux-arch@vger.kernel.org>; Fri, 26 Mar 2010 12:39:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o2QGdEja022502
	for <linux-arch@vger.kernel.org>; Fri, 26 Mar 2010 12:39:15 -0400
Content-Disposition: inline
In-Reply-To: <29095.1269514315@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org

On Thu, Mar 25, 2010 at 10:51:55AM +0000, David Howells wrote:
> 
> If a function needs both a spinlock and the RCU read lock, is there a best
> order in which they should be taken?  For instance, is:
> 
> 	spin_lock(&my_lock);
> 	rcu_read_lock();
> 	...
> 	rcu_read_unlock();
> 	spin_unlock(&my_lock);
> 
> better than:
> 
> 	rcu_read_lock();
> 	spin_lock(&my_lock);
> 	...
> 	spin_unlock(&my_lock);
> 	rcu_read_unlock();

The short answer is that it usually doesn't matter.

If you want the long answer...  In a !CONFIG_PREEMPT kernel, it won't
matter at all because rcu_read_lock() and rcu_read_unlock() generate
no code.  In a CONFIG_PREEMPT kernel, if you had a highly contended lock,
then the second approach would be marginally better, but it would be even
better to reduce that lock's contention, which would make it not matter.
On the other hand, if you were running in a -rt kernel, and again had
a highly contended lock, then the first approach would avoid blocking
in an RCU read-side critical section, which is a bit more efficient.
But again, it would be even better to reduce the contention on the lock.

> And does it make any different if spin_lock_irq*() is used?

Use of spin_lock_irq*() removes the -rt preference.

> In fact, should spin_lock_irq*() imply rcu_read_lock()?  Given that the
> current task can't be preempted if there can be no interrupt to do the
> preempting?

No, but spin_lock_irq*() -does- imply rcu_read_lock_sched() and
rcu_read_lock_bh().  As an accident of the implementation, but
-only- in non-rt kernels, spin_lock_irq*() happens to currently imply
rcu_read_lock(), but please, please, please do not write code relying
on this.  It will break.  :-(

							Thanx, Paul
