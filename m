Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j8CFfWfG327610
	for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2005 11:41:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8CFeGHk047134
	for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2005 09:40:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8CFeFnJ014468
	for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2005 09:40:16 -0600
Date: Mon, 12 Sep 2005 21:04:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 3/3][RFC] remove rcuref.h
Message-ID: <20050912153453.GB4778@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <432595D5.1090502@yahoo.com.au> <4325965A.2010608@yahoo.com.au> <432596EA.3020502@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432596EA.3020502@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 13, 2005 at 12:55:38AM +1000, Nick Piggin wrote:
> 3/3
> 
> So this is something like how one would go about removing rcuref.h.
> 
> Now I'm not proposing this for inclusion just yet. Obviously it needs
> to have the atomic_ primitives supported on all architectures and
> be reviewed by Dipankar and lkml...

The idea looks good. Please publish the full patcheset and we can
work towards merging them.

Thanks
Dipankar
