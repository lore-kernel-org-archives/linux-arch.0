Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:50226 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762180AbXHVXKr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2007 19:10:47 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7MNARMb025740
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 19:10:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7MNARP8074472
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 17:10:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7MNAQ3C007428
	for <linux-arch@vger.kernel.org>; Wed, 22 Aug 2007 17:10:27 -0600
Subject: Re: [RFC][PATCH] introduce TASK_SIZE_OF() for all arches
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20070822173044.GA1978@linux-mips.org>
References: <20070821193835.258D7DD4@kernel>
	 <20070821194309.GD9163@parisc-linux.org>
	 <20070822173044.GA1978@linux-mips.org>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 16:10:26 -0700
Message-Id: <1187824226.16177.1341.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-08-22 at 18:30 +0100, Ralf Baechle wrote:
> On Tue, Aug 21, 2007 at 01:43:09PM -0600, Matthew Wilcox wrote:
> 
> > On Tue, Aug 21, 2007 at 12:38:35PM -0700, Dave Hansen wrote:
> > > I'd like to have that for other architectures.  So, add it
> > > for all the architectures that actually use "current" in 
> > > their TASK_SIZE.  For the others, just add a quick #define
> > > in sched.h to use plain old TASK_SIZE.
> > 
> > MIPS seems to do things a little differently ... Ralf, what should Dave
> > be doing here?
> > 
> > #define TASK_SIZE32     0x7fff8000UL
> > #define TASK_SIZE       0x10000000000UL
> 
> Indeed. Below patch should do the trick.

Thanks for the patch.  I'll roll it into my larger one.

-- Dave

