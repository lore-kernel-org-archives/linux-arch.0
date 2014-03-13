Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:51919 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaCMNQO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Mar 2014 09:16:14 -0400
Message-ID: <5321AF96.6070909@redhat.com>
Date: Thu, 13 Mar 2014 14:16:06 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
 PV guest
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com> <53218E7A.8090707@citrix.com>
In-Reply-To: <53218E7A.8090707@citrix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Vrabel <david.vrabel@citrix.com>, Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140313131606.EIZqEz8qmnXOrQ2YkxKNixxBXiGIU_Gnpv3TA80a4Xg@z>

Il 13/03/2014 11:54, David Vrabel ha scritto:
> On 12/03/14 18:54, Waiman Long wrote:
>> Locking is always an issue in a virtualized environment as the virtual
>> CPU that is waiting on a lock may get scheduled out and hence block
>> any progress in lock acquisition even when the lock has been freed.
>>
>> One solution to this problem is to allow unfair lock in a
>> para-virtualized environment. In this case, a new lock acquirer can
>> come and steal the lock if the next-in-line CPU to get the lock is
>> scheduled out. Unfair lock in a native environment is generally not a
>> good idea as there is a possibility of lock starvation for a heavily
>> contended lock.
>
> I do not think this is a good idea -- the problems with unfair locks are
> worse in a virtualized guest.  If a waiting VCPU deschedules and has to
> be kicked to grab a lock then it is very likely to lose a race with
> another running VCPU trying to take a lock (since it takes time for the
> VCPU to be rescheduled).

Actually, I think the unfair version should be automatically selected if 
running on a hypervisor.  Per-hypervisor pvops can choose to enable the 
fair one.

Lock unfairness may be particularly evident on a virtualized guest when 
the host is overcommitted, but problems with fair locks are even worse.

In fact, RHEL/CentOS 6 already uses unfair locks if 
X86_FEATURE_HYPERVISOR is set.  The patch was rejected upstream in favor 
of pv ticketlocks, but pv ticketlocks do not cover all hypervisors so 
perhaps we could revisit that choice.

Measurements were done by Gleb for two guests running 2.6.32 with 16 
vcpus each, on a 16-core system.  One guest ran with unfair locks, one 
guest ran with fair locks.  Two kernel compilations ("time make -j 16 
all") were started at the same time on both guests, and times were as 
follows:

     unfair:                         fair:
     real 13m34.674s                 real 19m35.827s
     user 96m2.638s                  user 102m38.665s
     sys 56m14.991s                  sys 158m22.470s

     real 13m3.768s                  real 19m4.375s
     user 95m34.509s                 user 111m9.903s
     sys 53m40.550s                  sys 141m59.370s

Actually, interpreting the numbers shows an even worse slowdown.

Compilation took ~6.5 minutes in a guest when the host was not 
overcommitted, and with unfair locks everything scaled just fine.

Ticketlocks fell completely apart; during the first 13 minutes they were 
allotted 16*6.5=104 minutes of CPU time, and they spent almost all of it 
spinning in the kernel (102 minutes in the first run).  They did perhaps 
30 seconds worth of work because, as soon as the unfair-lock guest 
finished and the host was no longer overcommitted, compilation finished 
in 6 minutes.

So that's approximately 12x slowdown from using non-pv fair locks (vs. 
unfair locks) on a 200%-overcommitted host.

Paolo

>> With the unfair locking activated on bare metal 4-socket Westmere-EX
>> box, the execution times (in ms) of a spinlock micro-benchmark were
>> as follows:
>>
>>   # of    Ticket       Fair	    Unfair
>>   tasks    lock     queue lock    queue lock
>>   ------  -------   ----------    ----------
>>     1       135        135	     137
>>     2      1045       1120	     747
>>     3      1827       2345     	    1084
>>     4      2689       2934	    1438
>>     5      3736       3658	    1722
>>     6      4942       4434	    2092
>>     7      6304       5176          2245
>>     8      7736       5955          2388
>
> Are these figures with or without the later PV support patches?


