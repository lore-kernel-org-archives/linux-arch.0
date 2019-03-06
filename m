Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbfCFR0K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Mar 2019 12:26:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26HPRnZ059842
        for <linux-arch@vger.kernel.org>; Wed, 6 Mar 2019 12:26:09 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r2j1jt0r9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2019 12:26:09 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 6 Mar 2019 17:26:08 -0000
Date: Wed, 6 Mar 2019 09:26:08 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Reply-To: paulmck@linux.ibm.com
References: <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
 <20190226150450.GW32477@hirez.programming.kicks-ass.net>
 <ab631777-7cbd-4658-fb99-05d60ec5a1ea@gmail.com>
 <20190306165831.GZ32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306165831.GZ32477@hirez.programming.kicks-ass.net>
Message-ID: <20190306172608.GF13351@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Akira Yokosawa <akiyks@gmail.com>, Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190306172608.hutYvcylf6F8kr9H3CMOWTm2eWCfIv-KVTs8MNpl444@z>

On Wed, Mar 06, 2019 at 05:58:31PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 07, 2019 at 12:46:05AM +0900, Akira Yokosawa wrote:
> > So, I'm looking at the macro RELOC_HIDE() defined in include/linux/compiler-gcc.h.
> 
> > Am I the only one who was not aware of this gcc-specific macro?
> 
> It's one I regularly see, but had forgotten about in this context.
> 
> However; you can also fix things by adding asm volatile ("":::"memory");
> in places.
> 
> But that's not really the point; I would really rather have a cmdline
> knob to fix things. That way we can compile the kernel with and without
> and look for differences. -fno-unicorns or something :-)
> 
> While I understand some compiler people revel in UB and love to make
> unicorns happen, I think in this case the produces result is utterly
> insane.

Because I couldn't resist...

https://raphlinus.github.io/assets/Anything_is_Possible_scaled.jpg

							Thanx, Paul
