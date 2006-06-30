Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:41203 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932228AbWF3N2N
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 09:28:13 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.6/8.13.6) with ESMTP id k5UDSAD9129116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 13:28:11 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5UDUk6Y147066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 15:30:46 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5UDS9sI000597
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 15:28:09 +0200
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200606301509.16981.ak@suse.de>
References: <1151670404.11575.5.camel@localhost>
	 <200606301444.26446.ak@suse.de> <1151672682.11575.16.camel@localhost>
	 <200606301509.16981.ak@suse.de>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 15:28:06 +0200
Message-Id: <1151674086.11575.24.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-06-30 at 15:09 +0200, Andi Kleen wrote:
> > > I must say I still hate the negative !S390. It would be much better
> > > to define something positive. If PCI doesn't work maybe something 
> > > else.
> > 
> > Well, I don't like these negative !S390 depends as well. But I can't
> > help it, there is no other existing config symbol that can be used for a
> > positive dependency. Hardware that is built into the machine and is not
> > attached via some kind of bus does not have any dependency. 
> 
> 
> But one can be invented. 
> 
> DESKTOP_HARDWARE
> SMALL_IRON
> END_USER_PCI
> ...
> 
> Chose one.

None of them seems appropriate. The things the patch deactives for s390
are vastly different (ATA/IDE, Parallel port, Plug and Play, I2C, I2O
and so on). You will end up adding a lot of new config options. 

> What stops users from plugging a PCI sound card into your PCI slots 
> BTW?

Which PCI slot? s390 doesn't have PCI slots.

> Initially it can be set dependent on !S390 and then later migrated
> into all the architectures (you can probably recruit someone on l-k
> to do it if you don't want to do it yourself ...) 

I don't mind doing it but the question still is how.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


