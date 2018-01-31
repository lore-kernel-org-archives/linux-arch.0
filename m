Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55695 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbeAaKIi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Jan 2018 05:08:38 -0500
Date: Wed, 31 Jan 2018 11:08:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Message-ID: <20180131100822.GL2269@hirez.programming.kicks-ass.net>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131090006.onaopgyqthppoysi@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180131100822.3ztviGoNdgG8E2R9G8U-FCZjVa5V5usqOHkoWFbvbU4@z>

On Wed, Jan 31, 2018 at 10:00:06AM +0100, Ingo Molnar wrote:
> - Similary, some of the high level descriptions in tools/memory-model/README
>   should probably propagated into the source code files as well: for example
>   both tools/memory-model/lock.cat and linux-kernel.cat could be improved that
>   way.

This is something both Will and me have on our todo list, sadly we've
not had any time to work on this due to this pesky spectre crap.
