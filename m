From: Michael Neuling <mikey@neuling.org>
Subject: Re: [GIT PULL] Disintegrate and kill asm/system.h
Date: Thu, 29 Mar 2012 13:50:44 +1100
Message-ID: <30702.1332989444@neuling.org>
References: <5599.1332958811@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:43587 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933001Ab2C2Cuq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Mar 2012 22:50:46 -0400
In-reply-to: <5599.1332958811@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, arnd@arndb.de, hpa@zytor.com, sfr@canb.auug.org.au

> Here are a bunch of patches to disintegrate asm/system.h into a set of separate
> bits to relieve the problem of circular inclusion dependencies.
> 
> The following changes since commit 437538267b672f9320833907f1b5acbb2605f4be:
> 
>   Merge tag 'fbdev-updates-for-3.4' of git://github.com/schandinat/linux-2.6 (2012-03-22 20:43:40 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-asm_system.git split-asm-system_h

It would have been nice to have this in linux-next for a day or two to
sort out the merge issues,  hence....

This seems to have broken linus tree when compiling a pseries_defconfig

We are currently getting:
kernel/irq/irqdomain.c: In function 'irq_debugfs_init':
kernel/irq/irqdomain.c:698:63: error: 'powerpc_debugfs_root' undeclared (first use in this function)
kernel/irq/irqdomain.c:698:63: note: each undeclared identifier is reported only once for each function it appears in

  ae3a197 Disintegrate asm/system.h for PowerPC
is conflicting with 
  cc79ca6 irq_domain: Move irq_domain code from powerpc to kernel/irq
from Grant's tree.

Adding the following patch fixes it for pseries_defconfig, although I'm
not sure it's the right fix.

Grant: why does powerpc_debugfs_root appear in generic code?  This seems
very bogus.

Mikey

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index af48e59..3ebf4ef 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/fs.h>
+#include <asm/debug.h>
 
 #define IRQ_DOMAIN_MAP_LEGACY 0 /* driver allocated fixed range of irqs.
 				 * ie. legacy 8259, gets irqs 1..15 */
