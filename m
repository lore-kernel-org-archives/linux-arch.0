Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:35026 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932602AbWF3NEt
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 09:04:49 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.6/8.13.6) with ESMTP id k5UD4l9x066508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 13:04:48 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com [9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5UD7Mqu117196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 15:07:23 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5UD4jUG024696
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 15:04:46 +0200
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200606301444.26446.ak@suse.de>
References: <1151670404.11575.5.camel@localhost>
	 <200606301444.26446.ak@suse.de>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 15:04:42 +0200
Message-Id: <1151672682.11575.16.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-06-30 at 14:44 +0200, Andi Kleen wrote:
> On Friday 30 June 2006 14:26, Martin Schwidefsky wrote:
> > Hi folks,
> > it has been a few weeks since the s390 kconfig discussion died down.
> > I have put together a new patch that includes all of the suggestions
> > made so far. With this patch "make allyesconfig" and "make allmodconfig"
> > now works on s390.
> > 
> > Please check that it does not break anything on your favorite 
> > architecture. It really shouldn't but you never know. I want to push
> > this patch soon.
> 
> I must say I still hate the negative !S390. It would be much better
> to define something positive. If PCI doesn't work maybe something 
> else.

Well, I don't like these negative !S390 depends as well. But I can't
help it, there is no other existing config symbol that can be used for a
positive dependency. Hardware that is built into the machine and is not
attached via some kind of bus does not have any dependency. The only
possible way to deal with it would be a positive list of architecture
that have that piece of hardware. But the feeling was that a negative
list is better in that case. So until you have one of your clever ideas
we are pretty much stuck, aren't we ?

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


