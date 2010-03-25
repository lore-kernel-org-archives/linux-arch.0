From: David Howells <dhowells@redhat.com>
Subject: RCU read lock vs spinlocks
Date: Thu, 25 Mar 2010 10:51:55 +0000
Message-ID: <29095.1269514315@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29235 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab0CYKv7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Mar 2010 06:51:59 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org


If a function needs both a spinlock and the RCU read lock, is there a best
order in which they should be taken?  For instance, is:

	spin_lock(&my_lock);
	rcu_read_lock();
	...
	rcu_read_unlock();
	spin_unlock(&my_lock);

better than:

	rcu_read_lock();
	spin_lock(&my_lock);
	...
	spin_unlock(&my_lock);
	rcu_read_unlock();

And does it make any different if spin_lock_irq*() is used?

In fact, should spin_lock_irq*() imply rcu_read_lock()?  Given that the
current task can't be preempted if there can be no interrupt to do the
preempting?

David
