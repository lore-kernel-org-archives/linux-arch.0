Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:36325 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263180AbUB0Wje (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Feb 2004 17:39:34 -0500
Received: from hplms2.hpl.hp.com (hplms2.hpl.hp.com [15.0.152.33])
	by palrel10.hp.com (Postfix) with ESMTP id 5A8BA1C020C4
	for <linux-arch@vger.kernel.org>; Fri, 27 Feb 2004 14:39:32 -0800 (PST)
Received: from napali.hpl.hp.com (napali.hpl.hp.com [15.4.89.123])
	by hplms2.hpl.hp.com (8.12.10/8.12.10/HPL-PA Hub) with ESMTP id i1RMdUQa024482
	for <linux-arch@vger.kernel.org>; Fri, 27 Feb 2004 14:39:31 -0800 (PST)
Received: from napali.hpl.hp.com (napali [127.0.0.1])
	by napali.hpl.hp.com (8.12.11/8.12.11/Debian-1) with ESMTP id i1RMdUw4015678
	for <linux-arch@vger.kernel.org>; Fri, 27 Feb 2004 14:39:30 -0800
Date: Fri, 27 Feb 2004 14:39:30 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200402272239.i1RMdU7E015674@napali.hpl.hp.com>
Subject: remove irq_enter()/irq_exit() from hardirq.h
Reply-To: davidm@hpl.hp.com
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Recently, Ken Chen discovered a bug in the ia64 kernel which was
caused by irq_exit() calling do_softirq().  It's easy to fix this bug
(move irq_exit() to the correct place), but I'm wondering whether
leaving irq_enter()/irq_exit() in hardirq.h might invite someone to
use it outside of architecture-specific code (which is not the case at
the moment, as far as I can see).  This would be bad because great
care needs to be taken to ensure that do_softirq() gets called from
the right place.  In the case of ia64, there is one and only one place
where it should be called.  Thus, my inclination is to remove the two
functions from hardirq.h and to stick them in the ia64-specific
irq-handling code (irq_ia64.c).

What do others think?

	--david
