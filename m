Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:34181 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdB1VQs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2017 16:16:48 -0500
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v8 02/11] nios2: put setup.h in uapi
Date: Tue, 28 Feb 2017 21:47:28 +0100
Message-ID: <1488314857-28327-3-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1488314857-28327-1-git-send-email-nicolas.dichtel@6wind.com>
References: <20170228024844.GA28691@altlinux.org>
 <1488314857-28327-1-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, mmarek@suse.com
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de, ldv@altlinux.org, nicolas.dichtel@6wind.com, herbert@gondor.apana.org.au, linux-rdma@vger.kernel.org
Message-ID: <20170228204728.HhitYwpkK4ZeyJICas1FexZiXZykQry1vihYtdEJa6M@z>

This header file is exported, but from a userland pov, it's just a wrapper
to asm-generic/setup.h.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/nios2/include/uapi/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index e0bb972a50d7..69c965304146 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -2,4 +2,5 @@ include include/uapi/asm-generic/Kbuild.asm
 
 header-y += elf.h
 
+generic-y += setup.h
 generic-y += ucontext.h
-- 
2.8.1
