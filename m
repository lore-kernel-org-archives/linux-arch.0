From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [URGENT FIX PATCH] arch: restore generic-y += shmparam.h for some architectures
Date: Mon,  7 Jan 2019 11:08:08 +0900
Message-ID: <1546826888-29197-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Michal Simek <monstr@monstr.eu>, Stafford Horne <shorne@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Guan Xuetao <gxt@pku.edu.cn>, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org
List-Id: linux-arch.vger.kernel.org

For some reasons, I accidentally got rid of "generic-y += shmparam.h"
from some architectures.

Restore them to fix building c6x, h8300, hexagon, m68k, microblaze,
openrisc, and unicore32.

Fixes: d6e4b3e326d8 ("arch: remove redundant UAPI generic-y defines")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Hi Linus,

Could you pick up this directly?
Apology for breakage.



 arch/c6x/include/uapi/asm/Kbuild        | 1 +
 arch/h8300/include/uapi/asm/Kbuild      | 1 +
 arch/hexagon/include/uapi/asm/Kbuild    | 1 +
 arch/m68k/include/uapi/asm/Kbuild       | 1 +
 arch/microblaze/include/uapi/asm/Kbuild | 1 +
 arch/openrisc/include/uapi/asm/Kbuild   | 1 +
 arch/unicore32/include/uapi/asm/Kbuild  | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 0febf1a..6c6f630 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 0febf1a..6c6f630 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index c1b06dc..61d955c 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,3 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 960bf1e..b8b3525 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -2,3 +2,4 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generic-y += kvm_para.h
+generic-y += shmparam.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 97823ec..28823e3 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -2,4 +2,5 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 0febf1a..6c6f630 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 0febf1a..6c6f630 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
-- 
2.7.4
