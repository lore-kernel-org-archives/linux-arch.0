Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:53037 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1753810AbWKMCIh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 12 Nov 2006 21:08:37 -0500
From: Keith Owens <kaos@sgi.com>
Subject: Re: [patch 2.6.19-rc5 0/12] crash_stop: Summary 
In-reply-to: Your message of "Fri, 10 Nov 2006 20:45:05 CDT."
             <20061111014505.GA12814@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2006 13:08:34 +1100
Message-ID: <10293.1163383714@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: vgoyal@in.ibm.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Vivek Goyal (on Fri, 10 Nov 2006 20:45:05 -0500) wrote:
>On Thu, Nov 09, 2006 at 03:04:18PM +1100, Keith Owens wrote:
>Hi Keith,
>
>> All the kernel debug style tools (kdb, kgdb, nlkd, netdump, lkcd,
>> crash, kdump etc.) have a common requirement, they need to do a crash
>> stop of the systems.  This means stopping all the cpus, even if some of
>> the cpus are spinning disabled.  In addition, each cpu has to save
>> enough state to start the diagnosis of the problem.
>> 
>> * Each debug style tool has written its own code for interrupting the
>>   other cpus and for saving cpu state.
>> 
>> * Some tools try a normal IPI first then send a non-maskable interrupt
>>   after a delay.
>> 
>> * Some tools always send a NMI first, which can result in incomplete or
>>   wrong machine state if NMI arrives at the wrong time.
>> 
>
>What kind of problem one can run into if NMI is sent directly instead
>of trying an normal IPI first?

Incomplete cpu state on the cpus that are hit with NMI.  By definition,
NMI can be delivered at any time, with the cpu in any state.  It can be
in the middle of saving the state for a previous interrupt when NMI is
delivered.  On IA64, a cpu can even be in physical mode instead of
virtual mode when INIT is delivered.  All of which means that you have
incomplete or misleading information in your dump.

Sending a normal interrupt first, waiting a short while, then sending
an NMI later maximises the chance that we get good state for every cpu.

>On a general note, I am not sure how well suited this infrastructure
>is for crash dump needs. We are trying to follow one theme and that
>is run a bare minimal code after a system crash to increase reliabitity.

Agreed.  But you still have to stop all the existing cpus _and_ capture
their state before switching to the second kernel.  There is no point
in switching to a new kernel if you cannot get information about all
the cpus from the failing kernel.

>Avoid taking locks avoid relying on crashed task's stack etc. (if possible).
>Of course it is an ideal situation and we have not achieved that state but
>roughly that seems to be the long term goal. Looking at the patches it
>looks like it introduces lots of code to be run after crash and also
>uses smp_processor_id() which introduces a dependency on stack. This poses
>problem in stack overflow cases. Fernando from valinux, introduced 
>safe_smp_processor_id() call to read apic id from LAPIC instead of relying
>on the thread's stack. As of today, the crash path is no safe from stack
>overflow but we hope that someday it would be.

Good point.  I will look at converting crash_stop to use
safe_smp_processor_id.

