From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Q: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove
	single ipi fallback for smp_call_function_many())
Date: Wed, 18 Feb 2009 18:47:14 +0100
Message-ID: <20090218174714.GA19396@elte.hu>
References: <20090217213256.GJ6761@linux.vnet.ibm.com> <20090217214518.GA13189@redhat.com> <20090217223910.GM6761@linux.vnet.ibm.com> <20090218135212.GB23125@wotan.suse.de> <alpine.LFD.2.00.0902180744520.21686@localhost.localdomain> <20090218162116.GC29863@elte.hu> <alpine.LFD.2.00.0902180828430.21686@localhost.localdomain> <20090218165808.GA9120@elte.hu> <20090218170517.GA9769@elte.hu> <alpine.LFD.2.00.0902180913110.21686@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:58643 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351AbZBRRr4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Feb 2009 12:47:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902180913110.21686@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Yinghai Lu <yinghai@kernel.org>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jens Axboe <jens.axboe@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Wed, 18 Feb 2009, Ingo Molnar wrote:
> >
> > an off-list comment pointed out this piece of information as 
> > well:
> > 
> >   http://www.sandpile.org/ia32/coherent.htm
> > 
> >   A WRMSR to one of the x2APIC MSRs (0000_0800h...0000_0BFFh) is 
> >   not guaranteed to be serializing.
> > 
> > So i suspect we should just enclose it in smp_mb() pairs to make 
> > sure it's a full barrier in both directions?
> 
> Why would we care about "both directions"?
> 
> I think putting an sfence _before_ the wrmsr (and not even all 
> of them - just put it in front of the "send IPI" sequence) 
> should be fine. Any other ordering sounds like just 
> unnecessary overhead to me.
> 
> We do want this to be low-overhead, even if we probably don't 
> care _that_ much.

yeah, you are right, making sure prior stores become visible 
should be the only worry here.

	Ingo
