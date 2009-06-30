From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and
	improve lpage NUMA support
Date: Wed, 1 Jul 2009 00:31:38 +0200
Message-ID: <20090630223138.GH1241@elte.hu>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org> <20090630191517.GB20567@elte.hu> <alpine.DEB.1.10.0906301533400.29795@gentwo.org> <20090630213146.GA17492@elte.hu> <alpine.DEB.1.10.0906301809330.11362@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:53224 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbZF3Wbv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Jun 2009 18:31:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0906301809330.11362@gentwo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de


* Christoph Lameter <cl@linux-foundation.org> wrote:

> On Tue, 30 Jun 2009, Ingo Molnar wrote:
> 
> > But what if not? What if the kernel can run on up to 4096 CPUs 
> > and runs on a big box. Why should a virtual machine have the 
> > illogical choice between either wasting a lot of RAM 
> > preallocating stuff, or limiting its own extendability.
> 
> The kernel may be able to run on 4096 but the machines config 
> information that is available via ACPI knows how many processors 
> the machine we are booting on is able to add.

I think we might be talking past each other.

The usecase i'm talking about is to boot a generic, 
many-CPUs-capable kernel in a guest image.

How would you allow that guest to stay on 2 virtual CPUs but still 
be able to hot-plug many other CPUs if the guest context rises above 
its original CPU utilization?

	Ingo
