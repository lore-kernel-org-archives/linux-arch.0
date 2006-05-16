Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:27 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751630AbWEPIIG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 May 2006 04:08:06 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.6/8.13.6) with ESMTP id k4G884xC153946
	for <linux-arch@vger.kernel.org>; Tue, 16 May 2006 08:08:04 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4G89WcR118732
	for <linux-arch@vger.kernel.org>; Tue, 16 May 2006 10:09:32 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id k4G883nN012231
	for <linux-arch@vger.kernel.org>; Tue, 16 May 2006 10:08:04 +0200
Subject: Re: [patch] s390 kconfig cleanup.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20060515212431.GA25010@moss.sous-sol.org>
References: <20060515171645.GA11397@skybase> <200605151930.32241.ak@suse.de>
	 <20060515212431.GA25010@moss.sous-sol.org>
Content-Type: text/plain
Date: Tue, 16 May 2006 10:08:28 +0200
Message-Id: <1147766908.5289.4.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-05-15 at 14:24 -0700, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > > That is where the arch people get involved. Can we come
> > > up with a method how to "tag" all menus in the Kconfig files
> > > under drivers/ with a positive list of the architectures
> > > that actually want to include the menu/driver? Or even
> > > better tag the menu/driver with the bus that is required
> > > to attach the device?
> > 
> > Xen has a similar problem. They currently have tons of ugly negative
> > checks too. REAL_HARDWARE or similar is needed there, but it might
> > not fit the s390.
> > 
> > Checking PCI is a good start and should apply to most menus already.
> 
> I like the idea of extending this to the bus like PCI already does.
> Do you have some examples where this doesn't work well?

For example Memory Technology Device (MTD) support, Parallel port
support, Plug and Play support,  ATA/ATAPI/MFM/RLL support, ISDN
subsystem, Telephony Support, etc...

Search for all menus tagged with !S390 in the patch and you will get a
good overview.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


