From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v7 2/8] nios2: put setup.h in uapi
Date: Fri, 24 Feb 2017 17:49:10 +0100
Message-ID: <1487954956-23318-3-git-send-email-nicolas.dichtel@6wind.com>
References: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
 <1487954956-23318-1-git-send-email-nicolas.dichtel@6wind.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:59056 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdBXQtb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2017 11:49:31 -0500
In-Reply-To: <1487954956-23318-1-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>

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
