Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:56318 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946671Ab3BHQq5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2013 11:46:57 -0500
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sat, 9 Feb 2013 02:41:14 +1000
Message-ID: <51152B81.2050501@linux.vnet.ibm.com>
Date: Fri, 08 Feb 2013 22:14:49 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/45] CPU hotplug: stop_machine()-free CPU hotplug
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com> <510FBC01.2030405@linux.vnet.ibm.com> <87haloiwv0.fsf@rustcorp.com.au> <51134596.4080106@linux.vnet.ibm.com> <20130208154113.GV17833@n2100.arm.linux.org.uk>
In-Reply-To: <20130208154113.GV17833@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org, xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20130208164449.xN63GxZGr6u9HwLscEpiyPSTU2lkDak90Ow238BnDs4@z>

On 02/08/2013 09:11 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 07, 2013 at 11:41:34AM +0530, Srivatsa S. Bhat wrote:
>> On 02/07/2013 09:44 AM, Rusty Russell wrote:
>>> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
>>>> On 01/22/2013 01:03 PM, Srivatsa S. Bhat wrote:
>>>>                  Avg. latency of 1 CPU offline (ms) [stop-cpu/stop-m/c latency]
>>>>
>>>> # online CPUs    Mainline (with stop-m/c)       This patchset (no stop-m/c)
>>>>
>>>>       8                 17.04                          7.73
>>>>
>>>>      16                 18.05                          6.44
>>>>
>>>>      32                 17.31                          7.39
>>>>
>>>>      64                 32.40                          9.28
>>>>
>>>>     128                 98.23                          7.35
>>>
>>> Nice!
>>
>> Thank you :-)
>>
>>>  I wonder how the ARM guys feel with their quad-cpu systems...
>>>
>>
>> That would be definitely interesting to know :-)
> 
> That depends what exactly you'd like tested (and how) and whether you'd
> like it to be a test-chip based quad core, or an OMAP dual-core SoC.
> 

The effect of stop_machine() doesn't really depend on the CPU architecture
used underneath or the platform. It depends only on the _number_ of
_logical_ CPUs used.

And stop_machine() has 2 noticeable drawbacks:
1. It makes the hotplug operation itself slow
2. and it causes disruptions to the workloads running on the other
CPUs by hijacking the entire machine for significant amounts of time.

In my experiments (mentioned above), I tried to measure how my patchset
improves (reduces) the duration of hotplug (CPU offline) itself. Which is
also slightly indicative of the impact it has on the rest of the system.

But what would be nice to test, is a setup where the workloads running on
the rest of the system are latency-sensitive, and measure the impact of
CPU offline on them, with this patchset applied. That would tell us how
far is this useful in making CPU hotplug less disruptive on the system.

Of course, it would be nice to also see whether we observe any reduction
in hotplug duration itself (point 1 above) on ARM platforms with lot
of CPUs. [This could potentially speed up suspend/resume, which is used
rather heavily on ARM platforms].

The benefits from this patchset over mainline (both in terms of points
1 and 2 above) is expected to increase, with increasing number of CPUs in
the system.

Regards,
Srivatsa S. Bhat

