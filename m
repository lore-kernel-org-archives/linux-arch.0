Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:14417 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S965213AbWIERRc
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 13:17:32 -0400
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k85HHVA7181044
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 17:17:31 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k85HJaZQ1552586
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:19:36 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k85HHU0C008318
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:17:30 +0100
Subject: Re: [patch 1/5] Kconfig: refine some depend statements.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20060905165032.GI2558@parisc-linux.org>
References: <20060905163305.GB6510@skybase>
	 <20060905165032.GI2558@parisc-linux.org>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 19:17:29 +0200
Message-Id: <1157476649.13223.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-05 at 10:50 -0600, Matthew Wilcox wrote:
> >  menu "IEEE 1394 (FireWire) support"
> > +     depends on PCI || BROKEN
> 
> Why the || BROKEN?

That was the conclusion last time as far as I can remember. The essence
of the statement was that firewire works for PCI, any other use is
broken. We can change that to "PCI" only if that is ok with everbody.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


