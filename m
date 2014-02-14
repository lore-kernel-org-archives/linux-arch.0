From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 13/52] sparc, sysfs: Fix CPU hotplug callback
 registration
Date: Fri, 14 Feb 2014 13:30:49 -0500 (EST)
Message-ID: <20140214.133049.832801765872021685.davem@davemloft.net>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
	<20140214075204.22701.72009.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:35146 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbaBNSa5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2014 13:30:57 -0500
In-Reply-To: <20140214075204.22701.72009.stgit@srivatsabhat.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 14 Feb 2014 13:22:05 +0530

> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:
 ...
> This is wrong, since it is prone to ABBA deadlocks involving the
> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
> with CPU hotplug operations).
> 
> Instead, the correct and race-free way of performing the callback
> registration is:
 ...
> Fix the sysfs code in sparc by using this latter form of callback
> registration.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>
