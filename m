From: Vladimir Murzin <murzin.v@gmail.com>
Subject: Re: [PATCH 0/6] get rid of extra check for TASK_SIZE in
 get_unmapped_area
Date: Thu, 10 May 2012 22:08:49 +0400
Message-ID: <20120510180842.GA3808@pinguin>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
 <20120509162657.GC10241@n2100.arm.linux.org.uk>
 <20120509175557.GA2823@pinguin>
 <20120509180701.GE10241@n2100.arm.linux.org.uk>
 <20120510030136.GA2665@pinguin>
 <20120510075504.GB3190@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45520 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890Ab2EJSLP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2012 14:11:15 -0400
Received: by lbbgm6 with SMTP id gm6so1295631lbb.19
        for <linux-arch@vger.kernel.org>; Thu, 10 May 2012 11:11:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120510075504.GB3190@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org

On Thu, May 10, 2012 at 08:55:04AM +0100, Russell King - ARM Linux wrote:
> On Thu, May 10, 2012 at 07:01:46AM +0400, Vladimir Murzin wrote:
> > I was thinking about your suggestion. We are speaking about the same
> > problem but different solutions. Let me summarize shortly why I came
> > up with current solution:
> 
> I don't think there is a problem here.  I think there's just redundant
> code in every arch apart from Sparc.
> 
> >    * leaving check in arches make them isolated, so
> >      mm->get_unmapped_area could be called safely anywhere (currently it
> >      is done in hugetlb and get_fb_unmapped_area stuff)
> 
> Right.  So is get_fb_unmapped_area() called without first going through
> get_unmapped_area() ?  As far as I can see, it isn't.  Same for hugetlbfs.

D'0h I've missed f_op there.. Thanks for pointing that.

> 
> I don't think you've analysed the issue you are trying to address correctly.
> As such I will *not* be giving you an ACK for your current changes to
> arch/arm.

I should have analysed this more carefully. By now I can see even more
redundant code. Actually, for some arches test for length has already
done in arch_mmap_check(). For instance, sparc32 and sparc64 do the
same check in sparc_mmap_check() as in arch_get_unmapped_area(). The
only one difference in return value: -EINVAL in lieu of -ENOMEM.
The same case for ia64.

Hmmm... What about extending generic arch_mmap_check with check (len >
TASK_SIZE) and updating arches which are coping with special cases?

Best wishes
Vladimir Murzin
