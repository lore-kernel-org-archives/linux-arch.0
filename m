From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/6] get rid of extra check for TASK_SIZE in
	get_unmapped_area
Date: Thu, 10 May 2012 08:55:04 +0100
Message-ID: <20120510075504.GB3190@n2100.arm.linux.org.uk>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com> <20120509162657.GC10241@n2100.arm.linux.org.uk> <20120509175557.GA2823@pinguin> <20120509180701.GE10241@n2100.arm.linux.org.uk> <20120510030136.GA2665@pinguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37552 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab2EJHzQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2012 03:55:16 -0400
Content-Disposition: inline
In-Reply-To: <20120510030136.GA2665@pinguin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <murzin.v@gmail.com>
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org

On Thu, May 10, 2012 at 07:01:46AM +0400, Vladimir Murzin wrote:
> I was thinking about your suggestion. We are speaking about the same
> problem but different solutions. Let me summarize shortly why I came
> up with current solution:

I don't think there is a problem here.  I think there's just redundant
code in every arch apart from Sparc.

>    * leaving check in arches make them isolated, so
>      mm->get_unmapped_area could be called safely anywhere (currently it
>      is done in hugetlb and get_fb_unmapped_area stuff)

Right.  So is get_fb_unmapped_area() called without first going through
get_unmapped_area() ?  As far as I can see, it isn't.  Same for hugetlbfs.

I don't think you've analysed the issue you are trying to address correctly.
As such I will *not* be giving you an ACK for your current changes to
arch/arm.
