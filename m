Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59080 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261178AbUCAMUY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Mar 2004 07:20:24 -0500
Subject: Re: remove irq_enter()/irq_exit() from hardirq.h
Message-ID: <OF6F51D31D.962B15AE-ONC1256E4A.00424524-C1256E4A.00434172@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 1 Mar 2004 13:14:36 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@napali.hpl.hp.com, davidm@hpl.hp.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>





> > but I'm wondering whether
> > leaving irq_enter()/irq_exit() in hardirq.h might invite someone to
> > use it outside of architecture-specific code (which is not the case at
> > the moment, as far as I can see).
>
> I agree with you, it shouldn't be publicly visible.  The s390 guys will
> need to do some work as their drivers reference these two routines (ie.
> grep under drivers/s390/)

Well, drivers/s390/cio is not really a driver. The main interrupt function
for i/o interrupts do_IRQ lives in driver/s390/cio/cio.c and not in
arch/s390/kernel/irq.c where you might expect to find it. The irq_enter/
irq_exit pair we just added in the sclp driver can be replaced with
a local_bh_enable/local_bh_disable pair. So we are pretty clean.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com
