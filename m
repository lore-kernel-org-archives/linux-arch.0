Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:46517 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946866AbWKKBpo
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Nov 2006 20:45:44 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAB1jiLV019354
	for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2006 20:45:44 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAB1jit1511802
	for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2006 18:45:44 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAB1jhJc027006
	for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2006 18:45:43 -0700
Date: Fri, 10 Nov 2006 20:45:05 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 2.6.19-rc5 0/12] crash_stop: Summary
Message-ID: <20061111014505.GA12814@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@sgi.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Nov 09, 2006 at 03:04:18PM +1100, Keith Owens wrote:
Hi Keith,

> All the kernel debug style tools (kdb, kgdb, nlkd, netdump, lkcd,
> crash, kdump etc.) have a common requirement, they need to do a crash
> stop of the systems.  This means stopping all the cpus, even if some of
> the cpus are spinning disabled.  In addition, each cpu has to save
> enough state to start the diagnosis of the problem.
> 
> * Each debug style tool has written its own code for interrupting the
>   other cpus and for saving cpu state.
> 
> * Some tools try a normal IPI first then send a non-maskable interrupt
>   after a delay.
> 
> * Some tools always send a NMI first, which can result in incomplete or
>   wrong machine state if NMI arrives at the wrong time.
> 

What kind of problem one can run into if NMI is sent directly instead
of trying an normal IPI first?

On a general note, I am not sure how well suited this infrastructure
is for crash dump needs. We are trying to follow one theme and that
is run a bare minimal code after a system crash to increase reliabitity.

Avoid taking locks avoid relying on crashed task's stack etc. (if possible).
Of course it is an ideal situation and we have not achieved that state but
roughly that seems to be the long term goal. Looking at the patches it
looks like it introduces lots of code to be run after crash and also
uses smp_processor_id() which introduces a dependency on stack. This poses
problem in stack overflow cases. Fernando from valinux, introduced 
safe_smp_processor_id() call to read apic id from LAPIC instead of relying
on the thread's stack. As of today, the crash path is no safe from stack
overflow but we hope that someday it would be.

So I think crash dump will be a little special case and we need to be 
careful while introducing extra code that new code will be able to run even 
if system is in very bad state. (for example stack overflow).

Thanks
Vivek

