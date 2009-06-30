From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and
	improve lpage NUMA support
Date: Tue, 30 Jun 2009 23:31:46 +0200
Message-ID: <20090630213146.GA17492@elte.hu>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org> <20090630191517.GB20567@elte.hu> <alpine.DEB.1.10.0906301533400.29795@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:53993 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbZF3Vcy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Jun 2009 17:32:54 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0906301533400.29795@gentwo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de


* Christoph Lameter <cl@linux-foundation.org> wrote:

> On Tue, 30 Jun 2009, Ingo Molnar wrote:
> 
> > Yeah, it's a bug for something like a virtual environment which 
> > boots generic kernels that might have 64 possible CPUs (on a 
> > true 64-way system), but which will have fewer in practice.

i think this bit should be quoted too, because it is the crux of the 
issue:

> > It's pretty basic stuff: the on-demand allocation of percpu 
> > resources.

> A machine (and a virtual environment) can indicate via the BIOS 
> tables or ACPI that there are less "possible" cpus. That is 
> actually very common.
> 
> The difference between actual and possible cpus only has to be the 
> number of processors that could be brought up later. In a regular 
> system that is pretty much zero. In a fancy system with actual 
> hotpluggable cpus there would be a difference but usually the 
> number of hotpluggable cpus is minimal.

You are arguing against the concept of the demand-allocation of 
resources, and i dont think that technical argument can be won.

Sure you dont have to demand-allocate if you know the demand 
beforehand and can preallocate and size accordingly.

But what if not? What if the kernel can run on up to 4096 CPUs and 
runs on a big box. Why should a virtual machine have the illogical 
choice between either wasting a lot of RAM preallocating stuff, or 
limiting its own extendability.

In other words: your proposed change in essence reduces the utility 
of CPU hotplug. It's a bad idea.

	Ingo
