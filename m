Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:25725 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932219AbWEQMYW
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 May 2006 08:24:22 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.6/8.13.6) with ESMTP id k4HCOLtv077310
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 12:24:21 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4HCPoeV118550
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 14:25:50 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id k4HCOKpC016051
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 14:24:20 +0200
Subject: Re: [patch] s390 kconfig cleanup.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <Pine.LNX.4.62.0605171408240.30686@pademelon.sonytel.be>
References: <20060515171645.GA11397@skybase> <200605151930.32241.ak@suse.de>
	 <20060515212431.GA25010@moss.sous-sol.org>
	 <1147766908.5289.4.camel@localhost>
	 <20060516211216.GE23243@moss.sous-sol.org>
	 <1147853851.6661.2.camel@localhost>
	 <Pine.LNX.4.62.0605171314440.30686@pademelon.sonytel.be>
	 <1147864946.5540.1.camel@localhost>
	 <Pine.LNX.4.62.0605171323330.30686@pademelon.sonytel.be>
	 <1147867671.5540.3.camel@localhost>
	 <Pine.LNX.4.62.0605171408240.30686@pademelon.sonytel.be>
Content-Type: text/plain
Date: Wed, 17 May 2006 14:24:21 +0200
Message-Id: <1147868661.5540.10.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2006-05-17 at 14:12 +0200, Geert Uytterhoeven wrote:
> > Hmm, so far s390 has lived quite happily without /dev/rtc. What is the
> > added benefit to have an emulation of a hardware interface that doesn't
> > exists for the architecture ?
> 
> hwclock(8) can query the hardware clock?
> 
> Originally hwclock used direct I/O accesses, which of course work on PC
> hardware only, but on `newer' systems it uses /dev/rtc.

What is hwclock? ;-)
That utility is not compiled / used on s390 distributions. We could add
genrtc, readd hwclock to the util-linux compile for s390 and just call
it in the init scripts. Some of the current scripts have something like
  if [ `uname -s` == "Linux" -a `uname -m` != "s390" ]
  then ...
around the calls to hwclock.
And it would be easy to do, just remove the !S390 from the GEN_RTC
option in my cleanup patch.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


