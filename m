Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fmr23.intel.com ([143.183.121.15]:40598 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751317AbWCFUPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2006 15:15:24 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Request for feedback on Generic Timeofday Subsystem (B20)
Date: Mon, 6 Mar 2006 12:15:19 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Why do we need this?
>
> Correctness: ...
> Consolidation: ...

Any performance measurements?  ia64 has gone to some lengths to
ensure that gettimeofday(2) has a very low overhead (it does
show up in the kernel profiles of some benchmarks ... managed
runtime systems in particular, but others like to get timestamps
at quite frighteningly short intervals).  So I'm interested in
smp cases where are moderate number of cpus (4-16) are pounding
on gettimeofday().  I think that the huge SMP systems running
HPC workloads spend less of their time asking what time it is,
so I'm not as worried about the 512 cpu ... but if all 512 cpus
do happen to call gettimeofday() at the same time the system
shouldn't sink into the swamp as cache-lines bounce around.

-Tony
