From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [GIT PULL, v3] Microblaze architecture (arch/microblaze/)
	support
Date: Tue, 14 Apr 2009 03:39:48 +0200
Message-ID: <20090414013948.GA30336@elte.hu>
References: <49DC4024.6090800@petalogix.com> <alpine.LFD.2.00.0904131818050.26713@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:51780 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbZDNBkn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Apr 2009 21:40:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904131818050.26713@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Simek <michal.simek@petalogix.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, lkml <linux-arch@vger.kernel.org>, microblaze-uclinux@itee.uq.edu.au, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, John Williams <john.williams@petalogix.com>, John Linn <John.Linn@xilinx.com>, Stephen Neuendorffer <stephenn@xilinx.com>, Thomas Gleixner <tglx@linutronix.de>, Randy Dunlap <randy.dunlap@oracle.com>, Peter Korsgaard <jacmet@sunsite.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 8 Apr 2009, Michal Simek wrote:
> > 
> > This repository contains Linux support for Xilinx Microblaze CPU.
> > 
> > Please pull
> >     git://git.monstr.eu/linux-2.6-microblaze.git for-linus
> 
> So I pulled, but I notice that there's a few empty header files.
> 
> That looks intentional (they came in through a commit that says 
> "headers simple files - empty or redirect to asm-generic"), but it 
> means that "make distclean" will remove them. So if you really 
> want an empty header file, you should really make it not 
> _completely_ empty - add a comment to it or something.

FYI, there's a patch queued up by Michal for this - see below. It's 
Tested-by Jeff as well. You might want to apply this from email if 
you want a distclean-correct -rc2 ?

	Ingo

----- Forwarded message from monstr@monstr.eu -----

Date: Mon, 13 Apr 2009 20:56:57 +0200
From: monstr@monstr.eu
To: jeff@garzik.org
Subject: [PATCH 1/1] microblaze: Fix problem with removing zero length files
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>

From: Michal Simek <monstr@monstr.eu>

Adding one new line was recommended solution.
Test with make distclean

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/auxvec.h   |    1 +
 arch/microblaze/include/asm/cputable.h |    1 +
 arch/microblaze/include/asm/hw_irq.h   |    1 +
 arch/microblaze/include/asm/user.h     |    1 +
 arch/microblaze/include/asm/vga.h      |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/microblaze/include/asm/auxvec.h b/arch/microblaze/include/asm/auxvec.h
index e69de29..8b13789 100644
--- a/arch/microblaze/include/asm/auxvec.h
+++ b/arch/microblaze/include/asm/auxvec.h
@@ -0,0 +1 @@
+
diff --git a/arch/microblaze/include/asm/cputable.h b/arch/microblaze/include/asm/cputable.h
index e69de29..8b13789 100644
--- a/arch/microblaze/include/asm/cputable.h
+++ b/arch/microblaze/include/asm/cputable.h
@@ -0,0 +1 @@
+
diff --git a/arch/microblaze/include/asm/hw_irq.h b/arch/microblaze/include/asm/hw_irq.h
index e69de29..8b13789 100644
--- a/arch/microblaze/include/asm/hw_irq.h
+++ b/arch/microblaze/include/asm/hw_irq.h
@@ -0,0 +1 @@
+
diff --git a/arch/microblaze/include/asm/user.h b/arch/microblaze/include/asm/user.h
index e69de29..8b13789 100644
--- a/arch/microblaze/include/asm/user.h
+++ b/arch/microblaze/include/asm/user.h
@@ -0,0 +1 @@
+
diff --git a/arch/microblaze/include/asm/vga.h b/arch/microblaze/include/asm/vga.h
index e69de29..8b13789 100644
--- a/arch/microblaze/include/asm/vga.h
+++ b/arch/microblaze/include/asm/vga.h
@@ -0,0 +1 @@
+
-- 
1.5.5.1

----- End forwarded message -----
