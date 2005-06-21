Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j5LFwQMg004390
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 11:58:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j5LFwKW1091340
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 11:58:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j5LFw94x005008
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 11:58:10 -0400
Subject: Re: sparsemem patches in -mm
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20050621110006.GH23911@localhost.localdomain>
References: <20050621021352.46fc3b81.akpm@osdl.org>
	 <20050621110006.GH23911@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 08:57:56 -0700
Message-Id: <1119369476.27442.30.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Bob Picco <bob.picco@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Matt Tolentino <matthew.e.tolentino@intel.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-06-21 at 07:00 -0400, Bob Picco wrote:
> Andrew Morton wrote:	[Tue Jun 21 2005, 05:13:52AM EDT]
> > 
> > Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
> > please, if you haven't done so...
> > 
> Well ia64 SPARSEMEM hasn't been accepted yet by ia64.  I did test 
> SPARSEMEM with recent -mm patches on ia64 (EXTREME) and x86_64 4 way 
> Opteron (!EXTREME) with OSDL aim.

I think the whole set is just about ready for mainline.  If anybody
wants a consolidated set of patches that's easier to review, that's no
problem.

I'd only suggest that we keep the "extreme" stuff in -mm for a couple
more releases.  It's a pretty clean add-on, and it has only had a very
short time in -mm.  Bob, would you agree?

-- Dave
