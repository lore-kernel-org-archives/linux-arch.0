Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34154 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbGLWBt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2015 18:01:49 -0400
Received: by igvi1 with SMTP id i1so20372276igv.1
        for <linux-arch@vger.kernel.org>; Sun, 12 Jul 2015 15:01:49 -0700 (PDT)
Subject: [PATCH 0/3] IRQ trivial clarifications
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 12 Jul 2015 17:01:45 -0500
Message-ID: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20150712220145.sbuOe9Qj2uPkP0pwWEHfwTuTqxwVpYBZ68U0lOxkx4A@z>

These don't fix anything at all.  But they might make code understanding
and debugging slightly easier.

---

Bjorn Helgaas (3):
      x86, irq: Rename VECTOR_UNDEFINED and VECTOR_RETRIGGERED to IRQ_*
      x86, irq: Clarify "No irq handler" message
      IRQ: Print "unexpected IRQ" messages consistently across architectures


 arch/alpha/kernel/irq.c            |    2 +-
 arch/blackfin/kernel/irqchip.c     |    2 +-
 arch/c6x/kernel/irq.c              |    2 +-
 arch/ia64/kernel/irq.c             |    2 +-
 arch/m68k/include/asm/hardirq.h    |    2 +-
 arch/mips/kernel/irq.c             |    2 +-
 arch/mn10300/kernel/irq.c          |    2 +-
 arch/parisc/include/asm/hardirq.h  |    2 +-
 arch/powerpc/include/asm/hardirq.h |    2 +-
 arch/s390/include/asm/hardirq.h    |    2 +-
 arch/sh/kernel/irq.c               |    2 +-
 arch/tile/kernel/irq.c             |    2 +-
 arch/x86/include/asm/hw_irq.h      |    4 ++--
 arch/x86/kernel/apic/vector.c      |   14 +++++++-------
 arch/x86/kernel/irq.c              |   19 +++++++++----------
 arch/x86/kernel/irqinit.c          |    4 ++--
 include/asm-generic/hardirq.h      |    2 +-
 17 files changed, 33 insertions(+), 34 deletions(-)
