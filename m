From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 16/38] c6x: clean-up uapi Kbuild file
Date: Mon, 14 Jul 2014 17:08:44 +0200
Message-ID: <1405350546-28467-16-git-send-email-sam@ravnborg.org>
References: <20140714150609.GA28358@ravnborg.org>
 <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>
List-Id: linux-arch.vger.kernel.org

Remove redundant assignments.
Also drop kvm_para.h wrapper as it is never referenced from c6x code.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
---
 arch/c6x/include/uapi/asm/Kbuild | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index e9bc2b2..b15bf6b 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,12 +1,2 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
-
-generic-y += kvm_para.h
-
-header-y += byteorder.h
-header-y += kvm_para.h
-header-y += ptrace.h
-header-y += setup.h
-header-y += sigcontext.h
-header-y += swab.h
-header-y += unistd.h
-- 
1.9.3
