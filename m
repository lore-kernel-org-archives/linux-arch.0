From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and
	improve lpage NUMA support
Date: Wed, 1 Jul 2009 01:30:01 +0200
Message-ID: <20090630233001.GA28830@elte.hu>
References: <alpine.DEB.1.10.0906291920100.32637@gentwo.org> <20090629163937.94c8cedd.akpm@linux-foundation.org> <20090630191517.GB20567@elte.hu> <alpine.DEB.1.10.0906301533400.29795@gentwo.org> <20090630213146.GA17492@elte.hu> <alpine.DEB.1.10.0906301809330.11362@gentwo.org> <20090630223138.GH1241@elte.hu> <alpine.DEB.1.10.0906301847260.19482@gentwo.org> <20090630230743.GA17968@elte.hu> <alpine.DEB.1.10.0906301917170.15482@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:49433 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757769AbZF3XaW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Jun 2009 19:30:22 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0906301917170.15482@gentwo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de


* Christoph Lameter <cl@linux-foundation.org> wrote:

> On Wed, 1 Jul 2009, Ingo Molnar wrote:
> 
> > Say it says "256 CPUs".
> 
> Ok then you found a bug in the virtualization software ;-).

No, it runs on a 256 CPUs host system, why shouldnt it be possible 
to expose that _possible_ expansion space to a guest instance?

	Ingo
