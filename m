Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751827AbeBBIkz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Feb 2018 03:40:55 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w128eKtj019094
        for <linux-arch@vger.kernel.org>; Fri, 2 Feb 2018 03:40:54 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fvju2vkk8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 02 Feb 2018 03:40:54 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Feb 2018 03:40:52 -0500
Date: Thu, 1 Feb 2018 15:14:09 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180201011728.GL3741@linux.vnet.ibm.com>
 <20180201065742.efww6os2qiwi2vjj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201065742.efww6os2qiwi2vjj@gmail.com>
Message-ID: <20180201231409.GU3741@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180201231409.C83JBJaHQe8dAWtb8ZqCN83eJXGtesycoM6oUTAkPlA@z>

On Thu, Feb 01, 2018 at 07:57:42AM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > I believe these additional improvements (to the extent you agree with doing them!) 
> > > could/should be done as add-on commits on top of this existing commit.
> > 
> > Sounds good!
> > 
> > Would you prefer a pull request or a patch series for these?
> 
> Patch series would be nice, for review and later application to the locking tree.

Works for me!

I will curate the series on branch lkmm in my -rcu tree, and send the
series out non-RFC when I believe that it is ready for you.

							Thanx, Paul
