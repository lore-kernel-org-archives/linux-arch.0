From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v5 2/8] nios2: put setup.h in uapi
Date: Thu,  2 Feb 2017 14:25:04 +0100
Message-ID: <1486041910-2665-3-git-send-email-nicolas.dichtel@6wind.com>
References: <20170131162133.GA8258@gmail.com>
 <1486041910-2665-1-git-send-email-nicolas.dichtel@6wind.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486041910-2665-1-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>
List-Id: linux-arch.vger.kernel.org

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
