From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Get rid of cpuinit?
Date: Mon, 20 May 2013 15:35:43 -0700
Message-ID: <519AA53F.1020107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60978 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab3ETWgK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 May 2013 18:36:10 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <greg@kroah.com>

We have gotten rid of devinit markup.  A recent patch of Linus' makes me
wonder if we similarly should get rid of cpuinit markup?

Just as with devices, the CPU hotplug machinery has been leveraged to
support a number of pieces of functionality such as suspend, which means
that on anything but the most embedded systems this functionality is
likely needed anyway.

On x86-64, for an "allyesconfig" build, the total amount of space in all
the .cpu* sections combined is 100K.

	-hpa
