Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfETGBO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 02:01:14 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: remove asm-generic/ptrace.h v2
Date: Mon, 20 May 2019 08:00:13 +0200
Message-ID: <20190520060018.25569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190520060013.epMrVghJB7N9dg3ovwBCte7__eitzsaAu1n2OB4tD0o@z>

Hi all,

asm-generic/ptrace.h is a little weird in that it doesn't actually
implement any functionality, but it provided multiple layers of macros
that just implement trivial inline functions.  We implement those
directly in the few architectures and be off with a much simpler
design.

Changes since v1:
 - add a missing empty line between functions
