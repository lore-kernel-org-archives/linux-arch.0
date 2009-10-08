From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
 register a set of idle routines.
Date: Thu, 08 Oct 2009 12:50:33 +0200
Message-ID: <1254999033.26976.272.camel@twins>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	 <20091008095027.GC20595@linux.vnet.ibm.com>
	 <1254998162.26976.270.camel@twins>
	 <20091008104249.GJ20595@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([62.179.121.38]:57681 "EHLO
	viefep18-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbZJHKrj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2009 06:47:39 -0400
In-Reply-To: <20091008104249.GJ20595@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arun@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>, Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 2009-10-08 at 16:12 +0530, Arun R Bharadwaj wrote:
> 
> > So cpuidle didn't already have a list of idle functions it takes an
> > appropriate one from?
> > 
> 
> No.. As of now, cpuidle supported only one _set_ of idle states that
> can be registered. So in this one set, it would choose the appropriate
> idle state. But this list mechanism(actually a stack) allows for
> multiple sets.
> 
> This is needed because we have a hierarchy of idle states discovery
> in x86. First, select_idle_routine() would select poll/mwait/default/c1e.
> It doesn't know of existance of ACPI. Later when ACPI comes up,
> it registers a set of routines on top of the earlier set.
> 
> > Then what does this governor do?
> >
> 
> The governor would only select the best idle state available from the
> set of states which is at the top of the stack. (In the above case, it
> would only consider the states registered by ACPI).
> 
> If the top-of-the-stack set of idle states is unregistered, the next
> set of states on the stack are considered.
> 
> > Also, does this imply the governor doesn't consider these idle routines?
> >
> 
> As i said above, governor would only consider the idle routines which
> are at the top of the stack.
> 
> Hope this gave a better idea..

So does it make sense to have a set of sets?

Why not integrate them all into one set to be ruled by this governor
thing?
