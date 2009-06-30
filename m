From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and
	improve lpage NUMA support
Date: Wed, 1 Jul 2009 01:31:06 +0200
Message-ID: <20090630233106.GB28830@elte.hu>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org> <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org> <20090630191517.GB20567@elte.hu> <alpine.DEB.1.10.0906301533400.29795@gentwo.org> <20090630213146.GA17492@elte.hu> <alpine.DEB.1.10.0906301809330.11362@gentwo.org> <4A4A9DC6.6020003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:49655 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974AbZF3XbS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Jun 2009 19:31:18 -0400
Content-Disposition: inline
In-Reply-To: <4A4A9DC6.6020003@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de


* Tejun Heo <tj@kernel.org> wrote:

> Hello, Christoph.
> 
> Christoph Lameter wrote:

> > I looked at allocating for online cpus only a couple of years 
> > back but at that per cpu state was kept for offlined cpus in per 
> > cpu areas. There are numerous assumptions in per cpu handling 
> > all over the kernel that a percpu area is always available.
> 
> The plan is to allocate and keep percpu areas for cpus which have 
> ever been up.  There'll be no taking down of percpu areas.  
> Conversion from possible to has_ever_been_up should be much easier 
> than possible -> online.  State keeping will work fine too.

That sounds like a very sane plan.

	Ingo
