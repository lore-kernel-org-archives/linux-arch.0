Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:65124 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803AbaCNIsQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Mar 2014 04:48:16 -0400
Message-ID: <5322C249.6060502@redhat.com>
Date: Fri, 14 Mar 2014 09:48:09 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
 PV guest
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>	<20140313151515.GC25546@laptop.programming.kicks-ass.net>	<53220F7F.2040701@hp.com> <20140314083001.GN27965@twins.programming.kicks-ass.net>
In-Reply-To: <20140314083001.GN27965@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <waiman.long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>
Message-ID: <20140314084809.bE1y5DCMukHbLNc_n_zm0zKzSL7ZurUYR_b67WUbOfs@z>

Il 14/03/2014 09:30, Peter Zijlstra ha scritto:
> Take the situation of 3 (v)CPUs where cpu0 holds the lock but is
> preempted. cpu1 queues, cpu2 queues. Then cpu1 gets preempted, after
> which cpu0 gets back online.
>
> The simple test-and-set lock will now let cpu2 acquire. Your queue
> however will just sit there spinning, waiting for cpu1 to come back from
> holiday.
>
> I think you're way over engineering this. Just do the simple
> test-and-set lock for virt && !paravirt (as I think Paolo Bonzini
> suggested RHEL6 already does).

Exactly.

Paolo
