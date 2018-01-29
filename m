From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Mon, 29 Jan 2018 01:54:49 -0800
Message-ID: <20180129095449.GT3741@linux.vnet.ibm.com>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751072AbeA2Jyz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jan 2018 04:54:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0T9nfnq005776
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2018 04:54:55 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ft007unbj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2018 04:54:54 -0500
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 29 Jan 2018 04:54:53 -0500
Content-Disposition: inline
In-Reply-To: <20180129065724.ybrdsabvktq7fbqg@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Mon, Jan 29, 2018 at 07:57:24AM +0100, Ingo Molnar wrote:
> 
> hi Paul,
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Hello, Ingo,
> > 
> > This pull request contains a single commit that adds a memory model to
> > the tools directory.  This memory model can (roughly speaking) be thought
> > of as an automated version of memory-barriers.txt.  It is written in the
> > "cat" language, which is executable by the externally provided "herd7"
> > simulator, which exhaustively explores the state space of small litmus
> > tests.
> > 
> > This memory model is accompanied by extensive documentation on its use
> > and its design.  Two versions have been sent to LKML and feedback
> > incorporated:
> > 
> > 1.	http://lkml.kernel.org/r/20171113184031.GA26302@linux.vnet.ibm.com
> > 2.	http://lkml.kernel.org/r/20180119035855.GA29296@linux.vnet.ibm.com
> > 
> > This model has been presented and demoed at a number of Linux gatherings,
> > including the 2016 LinuxCon EU, the 2016 Linux Plumbers Conference,
> > the 2016 Linux Kernel Summit, the 2017 linux.conf.au, and the 2017 Linux
> > Plumbers Conference, which featured a workshop helping a number of Linux
> > kernel hackers install and use the tool.
> > 
> > This memory model has matured to the point where it would be good to include
> > it in the Linux kernel, for example, to allow it to track changes as new
> > hardware and use cases are added.  We expect the rate of change to be similar
> > to that of Documentation/memory-barriers.txt.
> > 
> > This memory model is available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git 
> > 
> > for you to fetch changes up to 1c27b644c0fdbc61e113b8faee14baeb8df32486:
> > 
> >   Automate memory-barriers.txt; provide Linux-kernel memory model (2018-01-24 20:53:49 -0800)
> 
> Looks good to me, but the commit is not in the master branch of your tree, which 
> branch should I pull?

Oops!!!  The branch is lkmm-for-mingo.

Please accept my apologies for the implicit maintainer treasure hunt!

							Thanx, Paul
