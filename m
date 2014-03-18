Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:42628 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbaCRIQ5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Mar 2014 04:16:57 -0400
Message-ID: <532800F0.10009@redhat.com>
Date: Tue, 18 Mar 2014 09:16:48 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
 PV guest
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>	<20140313151515.GC25546@laptop.programming.kicks-ass.net>	<53220F7F.2040701@hp.com>	<20140314083001.GN27965@twins.programming.kicks-ass.net>	<53273482.3030102@hp.com> <20140317185447.GM25546@laptop.programming.kicks-ass.net>
In-Reply-To: <20140317185447.GM25546@laptop.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <waiman.long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>
Message-ID: <20140318081648.1i9dfhOsklF7irW5NUZ2e8IsNX67Qjk-nSLWcPu0FN4@z>

Il 17/03/2014 19:54, Peter Zijlstra ha scritto:
> On Mon, Mar 17, 2014 at 01:44:34PM -0400, Waiman Long wrote:
>> The PV ticketlock code was designed to handle lock holder preemption by
>> redirecting CPU resources in a preempted guest to another guest that can
>> better use it and then return the preempted CPU back sooner.
>
> But that's the PV code, not the unfair bit. And your fuller PV thing
> doesn't need the unfair option.
>

I agree.  You need three cases:

* non-virt, non-PV: regular qspinlock

* virt (X86_FEATURE_HYPERVISOR), non-PV: test-and-set

* virt, PV: disables test-and-set, adds PV waiting to qspinlock

Paolo
