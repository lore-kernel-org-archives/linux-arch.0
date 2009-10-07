Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from viefep13-int.chello.at ([62.179.121.33]:62486 "EHLO
	viefep13-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933335AbZJGNQG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2009 09:16:06 -0400
Subject: Re: [v7 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
 management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
 cpuidle to POWER.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20091007112648.GC7646@dirshya.in.ibm.com>
References: <20091006152421.GA7278@linux.vnet.ibm.com>
	 <20091006163521.GA10425@linux.vnet.ibm.com>
	 <1254852279.17055.2.camel@laptop>
	 <20091007112648.GC7646@dirshya.in.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Oct 2009 15:05:11 +0200
Message-ID: <1254920711.26976.243.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: svaidy@linux.vnet.ibm.com
Cc: Arjan van de Ven <arjan@infradead.org>, arun@linux.vnet.ibm.com, Joel Schopp <jschopp@austin.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>, Gautham R Shenoy <ego@in.ibm.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20091007130511.C48hJsNzLimTE-ZdWeKi3UkdvFKnfTLlKJu2FMuSoTc@z>

On Wed, 2009-10-07 at 16:56 +0530, Vaidyanathan Srinivasan wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-10-06 20:04:39]:
> 
> > On Tue, 2009-10-06 at 22:05 +0530, Arun R Bharadwaj wrote:
> > 
> > > Also, the per-cpu nature of registration/unregistration of cpuidle
> > > has been maintained as ACPI needs this.
> > 
> > Right, so can't we ditch that and have acpi default to the lowest
> common
> > C-state and warn when various cpus report different C-states?
> 
> Hi Peter,
> 
> As Arjan mentioned previously, the per-cpu registration has to stay
> for x86 for now due to legacy ACPI compatibility.  Breaking that may
> break lot of existing users and we do not have a clean fallback
> method.  

From what I understood some broken ass bioses report different C state
availability on different CPUs in the same SMP system.

I'm suggesting to work around that by limiting all CPUs to the subset of
C states reported on all CPUs, instead of the current mess.

I haven't heard anybody tell me why that wouldn't be possible on x86

