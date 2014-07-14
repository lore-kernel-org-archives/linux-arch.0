From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 27/38] openrisc: clean-up uapi Kbuild file
Date: Mon, 14 Jul 2014 17:08:55 +0200
Message-ID: <1405350546-28467-27-git-send-email-sam@ravnborg.org>
References: <20140714150609.GA28358@ravnborg.org>
 <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Jonas Bonn <jonas@southpole.se>
List-Id: linux-arch.vger.kernel.org

Remove redundant assignments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Jonas Bonn <jonas@southpole.se>
---
 arch/openrisc/include/uapi/asm/Kbuild | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 80761eb..1ecfc9d 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,10 +1,4 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-header-y += byteorder.h
 header-y += elf.h
-header-y += kvm_para.h
-header-y += param.h
-header-y += ptrace.h
-header-y += sigcontext.h
-header-y += unistd.h
-- 
1.9.3
