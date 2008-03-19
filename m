Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:55291 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759449AbYCSTtX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2008 15:49:23 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2JCB5Kx005193
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2008 08:11:05 -0400
Received: from pobox.devel.redhat.com (pobox.devel.redhat.com [10.11.255.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2JCB4Yj024906
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2008 08:11:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: Policy for interrupts detected whilst disable_irq() in force
Date: Wed, 19 Mar 2008 12:11:03 +0000
Message-ID: <29183.1205928663@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com
Message-ID: <20080319121103.vPGyfd5ZxC1lDDLeNl3msDFWfE0duwMVmWjXFJhuxlM@z>


What's the policy for interrupts that are detected by the interrupt controller
on a channel that has disable_irq() in force?  Should the device driver expect
the interrupts to be lost?  Or can it expect that they'll be remembered and
that the CPU will process them when the IRQ channel is enabled?

Furthermore, what about an interrupt that is already pending when
disable_irq() is called?  Is it okay for that to be discarded?  Or must that
be processed upon enable_irq()?

MEI queried me about mn10300_cpupic_disable() in the MN10300 arch.  It clears
the channel enable bit and also clears the request and detect bits, thus losing
any pending interrupt.  Possibly I should introduce a separate shutdown()
method that discards any pending interrupt and modify disable() to merely clear
the enablement flag.

I would guess, however, that some hardware may not remember interrupts that
come in on disabled channels, in which case the driver cannot assume that
interrupts won't be lost.

Any thoughts?

David
