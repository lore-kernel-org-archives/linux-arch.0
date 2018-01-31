From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Wed, 31 Jan 2018 10:00:06 +0100
Message-ID: <20180131090006.onaopgyqthppoysi@gmail.com>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35911 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeAaJAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Jan 2018 04:00:12 -0500
Content-Disposition: inline
In-Reply-To: <20180129095449.GT3741@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> On Mon, Jan 29, 2018 at 07:57:24AM +0100, Ingo Molnar wrote:
> > 
> > hi Paul,
> > 
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > Hello, Ingo,
> > > 
> > > This pull request contains a single commit that adds a memory model to
> > > the tools directory.  This memory model can (roughly speaking) be thought
> > > of as an automated version of memory-barriers.txt.  It is written in the
> > > "cat" language, which is executable by the externally provided "herd7"
> > > simulator, which exhaustively explores the state space of small litmus
> > > tests.
> > > 
> > > This memory model is accompanied by extensive documentation on its use
> > > and its design.  Two versions have been sent to LKML and feedback
> > > incorporated:
> > > 
> > > 1.	http://lkml.kernel.org/r/20171113184031.GA26302@linux.vnet.ibm.com
> > > 2.	http://lkml.kernel.org/r/20180119035855.GA29296@linux.vnet.ibm.com
> > > 
> > > This model has been presented and demoed at a number of Linux gatherings,
> > > including the 2016 LinuxCon EU, the 2016 Linux Plumbers Conference,
> > > the 2016 Linux Kernel Summit, the 2017 linux.conf.au, and the 2017 Linux
> > > Plumbers Conference, which featured a workshop helping a number of Linux
> > > kernel hackers install and use the tool.
> > > 
> > > This memory model has matured to the point where it would be good to include
> > > it in the Linux kernel, for example, to allow it to track changes as new
> > > hardware and use cases are added.  We expect the rate of change to be similar
> > > to that of Documentation/memory-barriers.txt.
> > > 
> > > This memory model is available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git 
> > > 
> > > for you to fetch changes up to 1c27b644c0fdbc61e113b8faee14baeb8df32486:
> > > 
> > >   Automate memory-barriers.txt; provide Linux-kernel memory model (2018-01-24 20:53:49 -0800)
> > 
> > Looks good to me, but the commit is not in the master branch of your tree, which 
> > branch should I pull?
> 
> Oops!!!  The branch is lkmm-for-mingo.
> 
> Please accept my apologies for the implicit maintainer treasure hunt!

No problem, was able to pull it!

I really like this formal description of of the Linux kernel memory coherency 
model and the extensive documentation around it. Clearly a lot of effort went
into this work!

A couple of questions:

- Would it be possible to include all the nice descriptions of the litmus tests in
  the tests themselves? Right now it's a bit weird that most of them come with
  zero explanations, but the tools/memory-model/litmus-tests/README lists most of
  them.

- Similary, some of the high level descriptions in tools/memory-model/README
  should probably propagated into the source code files as well: for example
  both tools/memory-model/lock.cat and linux-kernel.cat could be improved that
  way.

- Could tools/memory-model/MAINTAINERS be added to the main Linux MAINTAINERS file 
  as well, like we do for other bits of tooling?

- There's no description about why the .bell file is called 'bell' and what 
  language/syntax it is in - I had to search around to figure out that it's a 
  "Bell extension" to .cat files. This aspect IMHO isn't really obvious to first 
  time readers so a bit more explanation would be nice.

- A high level question: have you considered calling it the "Linux kernel memory 
  coherency model", instead of the "Linux memory model"? Another naming would be 
  the "Linux kernel memory access model" as memory-barriers.txt calls it.
  The "memory model" name is overly generic, ambiguous and somewhat misleading,
  as we usually mean the virtual memory layout/model when we say "memory model".
  GCC too uses it in that sense: 'small memory model' and 'large memory model' -
  which too is about VM layout, not multiprocessing coherency.

- A long term question: have you considered and would it make sense to generate a
  memory-barriers.txt like file directly into Documentation/locking/, using the
  formal description? That way any changes/extensions/fixes to the model could be
  tracked on a high level, without readers having to understand the formal
  representation.

In any case, the base commit is certainly nice and clean and I've pulled it into 
tip:locking/core for a v4.17 merge.

I believe these additional improvements (to the extent you agree with doing them!) 
could/should be done as add-on commits on top of this existing commit.

Thanks,

	Ingo
