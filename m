From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH] earlycon: Fix __earlycon_table stride... again
Date: Tue, 13 Mar 2018 18:19:33 -0600
Message-ID: <20180314001933.5302-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: adurbin@chromium.org, Daniel Kurtz <djkurtz@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Commit 470ca0de69fe ("serial: earlycon: Enable earlycon without command
line param") added EARLYCON_TABLE().

Commit 99492c39f39f ("earlycon: Fix __earlycon_table stride") fixed
EARLYCON_TABLE() alignment to 32-bytes.

Commit 2eaa790989e0 ("earlycon: Use common framework for earlycon
declarations") added the compatible field, which bumped EARLYCON_TABLE()
alignment to 128 bytes (LCM of size of all fields of struct earlycon_id.

Correct the struct definition and linker alignment to match.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/serial_core.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ab0e520d6fc..2f7de2e36005 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -179,7 +179,7 @@
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
-#define EARLYCON_TABLE() STRUCT_ALIGN();			\
+#define EARLYCON_TABLE() . = ALIGN(128);		\
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 KEEP(*(__earlycon_table))		\
 			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..c9170b9ccb1b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -351,7 +351,7 @@ struct earlycon_id {
 	char	name[16];
 	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
-} __aligned(32);
+} __aligned(128);
 
 extern const struct earlycon_id __earlycon_table[];
 extern const struct earlycon_id __earlycon_table_end[];
-- 
2.16.2.804.g6dcf76e118-goog
