Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45169 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbbCPNgG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2015 09:36:06 -0400
Message-ID: <20150316131613.720617163@infradead.org>
Date: Mon, 16 Mar 2015 14:16:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/9] qspinlock stuff -v15
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman.Long@hp.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150316131613.NFxvkY5Fb7Ped-GxuzUKw0XvFPtn1hZAfKHiR9Z4MOQ@z>

Hi Waiman,

As promised; here is the paravirt stuff I did during the trip to BOS last week.

All the !paravirt patches are more or less the same as before (the only real
change is the copyright lines in the first patch).

The paravirt stuff is 'simple' and KVM only -- the Xen code was a little more
convoluted and I've no real way to test that but it should be stright fwd to
make work.

I ran this using the virtme tool (thanks Andy) on my laptop with a 4x
overcommit on vcpus (16 vcpus as compared to the 4 my laptop actually has) and
it both booted and survived a hackbench run (perf bench sched messaging -g 20
-l 5000).

So while the paravirt code isn't the most optimal code ever conceived it does work.

Also, the paravirt patching includes replacing the call with "movb $0, %arg1"
for the native case, which should greatly reduce the cost of having
CONFIG_PARAVIRT_SPINLOCKS enabled on actual hardware.

I feel that if someone were to do a Xen patch we can go ahead and merge this
stuff (finally!).

These patches do not implement the paravirt spinlock debug stats currently
implemented (separately) by KVM and Xen, but that should not be too hard to do
on top and in the 'generic' code -- no reason to duplicate all that.

Of course; once this lands people can look at improving the paravirt nonsense.

