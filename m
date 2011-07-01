From: Paul Walmsley <paul@pwsan.com>
Subject: Moving DT data out of the kernel?
Date: Fri, 1 Jul 2011 05:55:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107010534260.27025@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32873 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab1GALzl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2011 07:55:41 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@secretlab.ca>


Hello Linus,

Recently we've been discussing Device Tree and other forms of kernel 
static data.  Some of us were curious to know if you eventually planned to 
remove files like the ones in arch/powerpc/boot/dts/ from the mainline 
kernel source tree, or keep them in.

Do you have any preferences or plans here?


regards,

- Paul
