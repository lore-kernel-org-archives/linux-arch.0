Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel12.hp.com ([156.153.255.237]:44429 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261414AbUCAT76 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 14:59:58 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16451.38457.951988.853182@napali.hpl.hp.com>
Date: Mon, 1 Mar 2004 11:59:53 -0800
Subject: Re: remove irq_enter()/irq_exit() from hardirq.h
In-Reply-To: <OF6F51D31D.962B15AE-ONC1256E4A.00424524-C1256E4A.00434172@de.ibm.com>
References: <OF6F51D31D.962B15AE-ONC1256E4A.00424524-C1256E4A.00434172@de.ibm.com>
Reply-To: davidm@hpl.hp.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, davidm@napali.hpl.hp.com, davidm@hpl.hp.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Mon, 1 Mar 2004 13:14:36 +0100, Martin Schwidefsky <schwidefsky@de.ibm.com> said:

  >> > but I'm wondering whether
  >> > leaving irq_enter()/irq_exit() in hardirq.h might invite someone to
  >> > use it outside of architecture-specific code (which is not the case at
  >> > the moment, as far as I can see).
  >> 
  >> I agree with you, it shouldn't be publicly visible.  The s390 guys will
  >> need to do some work as their drivers reference these two routines (ie.
  >> grep under drivers/s390/)

  Martin> Well, drivers/s390/cio is not really a driver. The main
  Martin> interrupt function for i/o interrupts do_IRQ lives in
  Martin> driver/s390/cio/cio.c and not in arch/s390/kernel/irq.c
  Martin> where you might expect to find it. The irq_enter/ irq_exit
  Martin> pair we just added in the sclp driver can be replaced with a
  Martin> local_bh_enable/local_bh_disable pair. So we are pretty
  Martin> clean.

OK, it sounds like there is no good reason to keep them in hardirq.h.
For ia64, I'll move them to irq_ia64.c.  I won't touch other arches,
but for consistency's sake, it probably would be good to do a similar
thing on the other arches.

	--david
