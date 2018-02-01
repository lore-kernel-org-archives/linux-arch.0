From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Thu, 1 Feb 2018 07:57:42 +0100
Message-ID: <20180201065742.efww6os2qiwi2vjj@gmail.com>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180201011728.GL3741@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52372 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeBAG5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Feb 2018 01:57:47 -0500
Content-Disposition: inline
In-Reply-To: <20180201011728.GL3741@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> > I believe these additional improvements (to the extent you agree with doing them!) 
> > could/should be done as add-on commits on top of this existing commit.
> 
> Sounds good!
> 
> Would you prefer a pull request or a patch series for these?

Patch series would be nice, for review and later application to the locking tree.

Thanks,

	Ingo
