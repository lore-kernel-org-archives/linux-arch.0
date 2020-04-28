From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: [PATCH 1/2] powerpc: Keep .rela* sections when CONFIG_RELOCATABLE is defined
Date: Tue, 28 Apr 2020 06:21:04 -0700
Message-ID: <20200428132105.170886-1-hjl.tools@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

arch/powerpc/kernel/vmlinux.lds.S has

 #ifdef CONFIG_RELOCATABLE
 ...
        .rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
        {
                __rela_dyn_start = .;
                *(.rela*)
        }
 #endif
 ...
        DISCARDS
        /DISCARD/ : {
                *(*.EMB.apuinfo)
                *(.glink .iplt .plt .rela* .comment)
                *(.gnu.version*)
                *(.gnu.attributes)
                *(.eh_frame)
        }

Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
don't discard .rela* sections if CONFIG_RELOCATABLE is defined.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
 arch/powerpc/kernel/vmlinux.lds.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 31a0f201fb6f..4ba07734a210 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -366,9 +366,12 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		*(*.EMB.apuinfo)
-		*(.glink .iplt .plt .rela* .comment)
+		*(.glink .iplt .plt .comment)
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+#ifndef CONFIG_RELOCATABLE
+		*(.rela*)
+#endif
 	}
 }
-- 
2.25.4
