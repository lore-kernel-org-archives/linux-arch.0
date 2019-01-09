Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbfAIXkv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 18:40:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09NYAxe068236
        for <linux-arch@vger.kernel.org>; Wed, 9 Jan 2019 18:40:50 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pws7vkn25-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 18:40:50 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 23:40:49 -0000
Date: Wed, 9 Jan 2019 15:40:43 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Reply-To: paulmck@linux.ibm.com
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109231852.GA4494@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109231852.GA4494@andrea>
Message-ID: <20190109234043.GD1215@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
Message-ID: <20190109234043.gJmKv2fxF2yFdQWQ9GE1UBAZOw-lv9pfSRlJVM-YJkY@z>

On Thu, Jan 10, 2019 at 12:18:53AM +0100, Andrea Parri wrote:
> On Wed, Jan 09, 2019 at 01:07:06PM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series contains updates for the Linux-kernel memory model:
> > 
> > 1-3.	Add SRCU support, courtesy of Alan Stern.
> > 
> > 4.	Update README for adding of SRCU support.
> > 
> > 5.	Update memory-barriers.txt on enforcing heavy ordering for
> > 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> > 	an ack, preferably by someone from Intel.  Matthew Wilcox
> > 	posted some feedback from an Intel manual here, which might
> > 	be considered to be a close substitute, but...  ;-)
> > 
> > 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> > 
> > 6.	Update Documentation/explanation.txt to include SRCU support,
> > 	courtesy of Alan Stern.
> > 
> > 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> > 	Luc Maranget.  This needs an ack.
> 
> It seems that
> 
>   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
>   
> from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> considered that, IIRC, you introduced the primitive and RCU is currently
> its only user.)

That commit is in -tip:

4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")

So it has already left my -rcu tree.  ;-)

							Thanx, Paul
