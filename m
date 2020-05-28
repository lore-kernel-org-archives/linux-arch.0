From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Fri, 29 May 2020 00:16:59 +0200
Message-ID: <20200528221659.GS2483@worktop.programming.kicks-ass.net>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72>
 <20200528220047.GB211369@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44070 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436893AbgE1WRs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 18:17:48 -0400
Content-Disposition: inline
In-Reply-To: <20200528220047.GB211369@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>

On Thu, May 28, 2020 at 06:00:47PM -0400, Joel Fernandes wrote:

> Any idea why this choice of locking-based ring buffer implementation in BPF?
> The ftrace ring buffer can support NMI interruptions as well for writes.
> 
> Also, is it possible for BPF to reuse the ftrace ring buffer implementation
> or does it not meet the requirements?

Both perf and ftrace are per-cpu, which, according to the patch
description is too much memory overhead for them. Neither have ever
considered anything else, atomic ops are expensive.

On top of that, they want multi-producer support. Yes, doing that gets
interesting really fast, but using spinlocks gets you a trainwreck like
this.

This thing so readily wanting to drop data on the floor should worry
people, but apparently they've not spend enough time debugging stuff
with partial logs yet. Of course, bpf_prog_active already makes BPF
lossy, so maybe they went with that.

All reasons why I never bother with BPF, aside from it being more
difficult than hacking up a kernel in the first place.
