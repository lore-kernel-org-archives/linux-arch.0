Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728561AbfAJTDt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jan 2019 14:03:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AIx8eV107257
        for <linux-arch@vger.kernel.org>; Thu, 10 Jan 2019 14:03:48 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pxb8d1nax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 10 Jan 2019 14:03:47 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 19:03:46 -0000
Date: Thu, 10 Jan 2019 11:03:41 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Reply-To: paulmck@linux.ibm.com
References: <20190109210706.GA27268@linux.ibm.com>
 <Pine.LNX.4.44L0.1901101046480.1497-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901101046480.1497-100000@iolanthe.rowland.org>
Message-ID: <20190110190341.GV1215@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
Message-ID: <20190110190341.eyldqaIBSwsYaQsXv6j1r316W8BwOBHe1OQwlH3AqbE@z>

On Thu, Jan 10, 2019 at 10:47:26AM -0500, Alan Stern wrote:
> On Wed, 9 Jan 2019, Paul E. McKenney wrote:
> 
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
> Does this one still need an ack?  If so, you may apply mine.

Applied, thank you!

							Thanx, Paul
