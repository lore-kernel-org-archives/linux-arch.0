Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:36076 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932274AbWF3Myu
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 08:54:50 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.6/8.13.6) with ESMTP id k5UCsmlf089758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 12:54:49 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com [9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5UCvNh7053576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 14:57:24 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5UCsjDe010234
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 14:54:46 +0200
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <Pine.LNX.4.62.0606301435430.12536@pademelon.sonytel.be>
References: <1151670404.11575.5.camel@localhost>
	 <Pine.LNX.4.62.0606301435430.12536@pademelon.sonytel.be>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 14:54:43 +0200
Message-Id: <1151672083.11575.8.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, ak@suse.de, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-06-30 at 14:39 +0200, Geert Uytterhoeven wrote:
> > --- linux-2.6/drivers/char/Kconfig	2006-06-30 13:35:13.000000000 +0200
> > +++ linux-2.6-patched/drivers/char/Kconfig	2006-06-30 11:21:06.000000000 +0200
> > @@ -765,7 +767,7 @@ config SGI_IP27_RTC
> >  
> >  config GEN_RTC
> >  	tristate "Generic /dev/rtc emulation"
> > -	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
> > +	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
> 
> You still don't like genrtc (for hwclock)? ;-)

I haven't implemented it yet. But it is on my list of things to do.
Perhaps I can convince Heiko to look at it :-)

> > --- linux-2.6/drivers/ieee1394/Kconfig	2006-06-30 13:35:13.000000000 +0200
> > +++ linux-2.6-patched/drivers/ieee1394/Kconfig	2006-06-30 11:21:06.000000000 +0200
> > @@ -1,6 +1,7 @@
> >  # -*- shell-script -*-
> >  
> >  menu "IEEE 1394 (FireWire) support"
> > +	depends on PCI || BROKEN
> >  
> >  config IEEE1394
> >  	tristate "IEEE 1394 (FireWire) support"
> > diff -urpN linux-2.6/drivers/infiniband/Kconfig linux-2.6-patched/drivers/infiniband/Kconfig
> > --- linux-2.6/drivers/infiniband/Kconfig	2006-06-30 13:35:13.000000000 +0200
> > +++ linux-2.6-patched/drivers/infiniband/Kconfig	2006-06-30 11:21:06.000000000 +0200
> > @@ -1,4 +1,5 @@
> >  menu "InfiniBand support"
> > +	depends on !S390
> 
> Perhaps just `depends on PCI || BROKEN' (cfr. IEEE1394), so the whole menu will
> be hidden for other non-PCI platforms?

Ok, fine with me. One less depends on !S390.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


