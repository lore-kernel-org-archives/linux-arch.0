Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52454 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbcFCWeg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2016 18:34:36 -0400
Date: Sat, 4 Jun 2016 00:34:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 10/12] x86, rwsem: simplify __down_write
Message-ID: <20160603223417.GB3892@twins.programming.kicks-ass.net>
References: <1454444369-2146-1-git-send-email-mhocko@kernel.org>
 <1454444369-2146-11-git-send-email-mhocko@kernel.org>
 <20160203081016.GD32652@gmail.com>
 <20160603161339.GC3693@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160603161339.GC3693@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@us.ibm.com>, Jason Low <jason.low2@hpe.com>
Message-ID: <20160603223417.HZCUMRggqBCUD4O_VqYwYVAltMA6q-DqnN0hT32JXm8@z>

On Fri, Jun 03, 2016 at 06:13:39PM +0200, Peter Zijlstra wrote:
> So I've been playing with this again because Jason's atomic_long_t
> patches made a mess of things.
> 
> (similar findings for both ia64 and s390, suggesting killing all
> arch/*/include/asm/rwsem.h might actuyally be an option).
> 

Blergh; so looking at more asm there's still a few tricks we cannot do.
So while overall size is down, some paths do end up more expensive. (It
typically boils down to creative use of condition flags, which is very
hard in C)
