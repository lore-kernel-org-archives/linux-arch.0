From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 19/38] hexagon: clean-up uapi Kbuild file
Date: Mon, 14 Jul 2014 17:08:47 +0200
Message-ID: <1405350546-28467-19-git-send-email-sam@ravnborg.org>
References: <20140714150609.GA28358@ravnborg.org>
 <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Richard Kuo <rkuo@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

Remove redundant assignments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/include/uapi/asm/Kbuild | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index c31706c..3f464d5 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,15 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-header-y += bitsperlong.h
-header-y += byteorder.h
-header-y += kvm_para.h
-header-y += param.h
-header-y += ptrace.h
 header-y += registers.h
-header-y += setup.h
-header-y += sigcontext.h
-header-y += signal.h
-header-y += swab.h
-header-y += unistd.h
 header-y += user.h
-- 
1.9.3
