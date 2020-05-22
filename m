From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Fri, 22 May 2020 11:44:07 +0200
Message-ID: <20200522094407.GK325280@hirez.programming.kicks-ass.net>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgEVJop (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 05:44:45 -0400
Content-Disposition: inline
In-Reply-To: <20200522003850.GA32698@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andriin@fb.com

On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Just wanted to call your attention to some pretty cool and pretty serious
> litmus tests that Andrii did as part of his BPF ring-buffer work:
> 
> https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> 
> Thoughts?

I find:

	smp_wmb()
	smp_store_release()

a _very_ weird construct. What is that supposed to even do?
