Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([62.179.121.38]:56451 "EHLO
	viefep18-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933539AbZJGNVm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2009 09:21:42 -0400
Subject: Re: [v7 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
 management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
 cpuidle to POWER.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20091007114719.GH6818@balbir.in.ibm.com>
References: <20091006152421.GA7278@linux.vnet.ibm.com>
	 <20091006163521.GA10425@linux.vnet.ibm.com>
	 <1254852279.17055.2.camel@laptop>
	 <20091007112648.GC7646@dirshya.in.ibm.com>
	 <20091007114719.GH6818@balbir.in.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Oct 2009 15:24:17 +0200
Message-ID: <1254921857.26976.249.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: balbir@linux.vnet.ibm.com
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Arjan van de Ven <arjan@infradead.org>, arun@linux.vnet.ibm.com, Joel Schopp <jschopp@austin.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>, Gautham R Shenoy <ego@in.ibm.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20091007132417.Gc1kh1F36FvfF3-gipnoBYxCa1WoNTDncGbkzcVm5zk@z>

On Wed, 2009-10-07 at 17:17 +0530, Balbir Singh wrote:

> > The objective of the refactoring is to have a single common idle
> > routine management framework (remove pm_idle) and we have it done
> > through cpuidle registration framework.  We can incrementally remove
> > the per-cpu registration later easily by splitting the cpuidle_driver
> > structure.
> >
> 
> Yes, incremental refactoring makes the most sense from the do not
> break as you refactor point of view.

Sure,.. but I would have though getting rid of the per-cpu-ish-ness
would have made the latter patches in this series easier. But maybe I'm
lazy ;-)

Let me go over the patches one more time, but they do look ok.


