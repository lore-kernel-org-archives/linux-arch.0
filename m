From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Mon, 29 Jan 2018 07:57:24 +0100
Message-ID: <20180129065724.ybrdsabvktq7fbqg@gmail.com>
References: <20180125093440.GA875@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55609 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeA2G52 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jan 2018 01:57:28 -0500
Content-Disposition: inline
In-Reply-To: <20180125093440.GA875@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>


hi Paul,

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Hello, Ingo,
> 
> This pull request contains a single commit that adds a memory model to
> the tools directory.  This memory model can (roughly speaking) be thought
> of as an automated version of memory-barriers.txt.  It is written in the
> "cat" language, which is executable by the externally provided "herd7"
> simulator, which exhaustively explores the state space of small litmus
> tests.
> 
> This memory model is accompanied by extensive documentation on its use
> and its design.  Two versions have been sent to LKML and feedback
> incorporated:
> 
> 1.	http://lkml.kernel.org/r/20171113184031.GA26302@linux.vnet.ibm.com
> 2.	http://lkml.kernel.org/r/20180119035855.GA29296@linux.vnet.ibm.com
> 
> This model has been presented and demoed at a number of Linux gatherings,
> including the 2016 LinuxCon EU, the 2016 Linux Plumbers Conference,
> the 2016 Linux Kernel Summit, the 2017 linux.conf.au, and the 2017 Linux
> Plumbers Conference, which featured a workshop helping a number of Linux
> kernel hackers install and use the tool.
> 
> This memory model has matured to the point where it would be good to include
> it in the Linux kernel, for example, to allow it to track changes as new
> hardware and use cases are added.  We expect the rate of change to be similar
> to that of Documentation/memory-barriers.txt.
> 
> This memory model is available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git 
> 
> for you to fetch changes up to 1c27b644c0fdbc61e113b8faee14baeb8df32486:
> 
>   Automate memory-barriers.txt; provide Linux-kernel memory model (2018-01-24 20:53:49 -0800)

Looks good to me, but the commit is not in the master branch of your tree, which 
branch should I pull?

Thanks,

	Ingo
