From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and
	improve lpage NUMA support
Date: Wed, 1 Jul 2009 01:07:43 +0200
Message-ID: <20090630230743.GA17968@elte.hu>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org> <20090630191517.GB20567@elte.hu> <alpine.DEB.1.10.0906301533400.29795@gentwo.org> <20090630213146.GA17492@elte.hu> <alpine.DEB.1.10.0906301809330.11362@gentwo.org> <20090630223138.GH1241@elte.hu> <alpine.DEB.1.10.0906301847260.19482@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51552 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbZF3XH4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Jun 2009 19:07:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0906301847260.19482@gentwo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de


* Christoph Lameter <cl@linux-foundation.org> wrote:

> On Wed, 1 Jul 2009, Ingo Molnar wrote:
> 
> > The usecase i'm talking about is to boot a generic, 
> > many-CPUs-capable kernel in a guest image.
> 
> The many-cpu-capable kernel is not the issue. The number of 
> potential cpus is config information provided by the hardware. In 
> your case the host system provides the number of possible 
> processors.

Say it says "256 CPUs".

But i only run a 2 CPU guest system. But i want to run it with the 
_on demand capability_ to scale up to 256 virtual CPUs if needed, 
without having to reboot the guest and without having to allocate 
all the percpu space for 256 CPUs beforehand. Ok?

It is a simple, basic OS feature and concept.

	Ingo
