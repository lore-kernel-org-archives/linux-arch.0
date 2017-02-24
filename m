Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:59067 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbdBXQtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2017 11:49:32 -0500
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v7 3/8] x86: stop exporting msr-index.h to userland
Date: Fri, 24 Feb 2017 17:49:11 +0100
Message-ID: <1487954956-23318-4-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1487954956-23318-1-git-send-email-nicolas.dichtel@6wind.com>
References: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
 <1487954956-23318-1-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <20170224164911.HJRTI3WzetQid0ZXdZkJ4zENVwFEIRjK1UFJ0V4O-dk@z>

Even if this file was not in an uapi directory, it was exported because
it was listed in the Kbuild file.

Fixes: b72e7464e4cf ("x86/uapi: Do not export <asm/msr-index.h> as part of the user API headers")
Suggested-by: Borislav Petkov <bp@alien8.de>
CC: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/uapi/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 3dec769cadf7..1c532b3f18ea 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -27,7 +27,6 @@ header-y += ldt.h
 header-y += mce.h
 header-y += mman.h
 header-y += msgbuf.h
-header-y += msr-index.h
 header-y += msr.h
 header-y += mtrr.h
 header-y += param.h
-- 
2.8.1
