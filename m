Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 01:47:35 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: remove asm-generic/ptrace.h v3
Date: Mon, 24 Jun 2019 07:47:23 +0200
Message-ID: <20190624054728.30966-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190624054723.McySEwaLzvxkipyJRQ4joiL5z0m8QWfHsUDJqVAUfqk@z>

Hi all,

asm-generic/ptrace.h is a little weird in that it doesn't actually
implement any functionality, but it provided multiple layers of macros
that just implement trivial inline functions.  We implement those
directly in the few architectures and be off with a much simpler
design.

I'm not sure which tree is the right place, but may this can go through
the asm-generic tree since it removes an asm-generic header?


Changes since v2:
 - rebase to latest Linus' tree that added an SPDX tag to
   asm-generic/ptrace.h
 - collected two more Acks from Oleg
Changes since v1:
 - add a missing empty line between functions
