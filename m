From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 16/23] make section names compatible with -ffunction-sections -fdata-sections: ppc
Date: Wed, 2 Jul 2008 02:40:03 +0200
Message-ID: <200807020240.03443.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

The purpose of this patch is to make kernel buildable
with "gcc -ffunction-sections -fdata-sections".
This patch fixes ppc architecture.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/ppc/boot/ld.script	Wed Jul  2 00:40:41 2008
+++ 1.fixname/arch/ppc/boot/ld.script	Wed Jul  2 00:46:50 2008
@@ -41,7 +41,7 @@
   {
     *(.data)
     *(.data1)
-    *(.data.boot)
+    *(.boot.data)
     *(.sdata)
     *(.sdata2)
     *(.got.plt) *(.got)
--- 0.org/arch/ppc/boot/simple/misc-embedded.c	Wed Jul  2 00:40:41 2008
+++ 1.fixname/arch/ppc/boot/simple/misc-embedded.c	Wed Jul  2 00:46:50 2008
@@ -60,7 +60,7 @@
 
 /* We need to make sure that this is before the images to ensure
  * that it's in a mapped location. - Tom */
-bd_t hold_resid_buf __attribute__ ((__section__ (".data.boot")));
+bd_t hold_resid_buf __attribute__ ((__section__ (".boot.data")));
 bd_t *hold_residual = &hold_resid_buf;
 
 extern unsigned long serial_init(int chan, bd_t *bp);
--- 0.org/arch/ppc/boot/simple/openbios.c	Wed Jul  2 00:40:41 2008
+++ 1.fixname/arch/ppc/boot/simple/openbios.c	Wed Jul  2 00:46:50 2008
@@ -41,7 +41,7 @@
 
 /* We need to make sure that this is before the images to ensure
  * that it's in a mapped location. */
-bd_t hold_resid_buf __attribute__ ((__section__ (".data.boot")));
+bd_t hold_resid_buf __attribute__ ((__section__ (".boot.data")));
 bd_t *hold_residual = &hold_resid_buf;
 
 typedef struct openbios_board_info {
--- 0.org/arch/ppc/boot/simple/pibs.c	Wed Jul  2 00:40:41 2008
+++ 1.fixname/arch/ppc/boot/simple/pibs.c	Wed Jul  2 00:46:50 2008
@@ -16,7 +16,7 @@
 
 /* We need to make sure that this is before the images to ensure
  * that it's in a mapped location. - Tom */
-bd_t hold_resid_buf __attribute__ ((__section__ (".data.boot")));
+bd_t hold_resid_buf __attribute__ ((__section__ (".boot.data")));
 bd_t *hold_residual = &hold_resid_buf;
 
 /* String functions lifted from lib/vsprintf.c and lib/ctype.c */
--- 0.org/arch/ppc/kernel/vmlinux.lds.S	Wed Jul  2 00:40:41 2008
+++ 1.fixname/arch/ppc/kernel/vmlinux.lds.S	Wed Jul  2 00:46:03 2008
@@ -78,18 +78,18 @@
 
   . = ALIGN(4096);
   __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
+  .data_nosave : { *(.nosave.data) }
   . = ALIGN(4096);
   __nosave_end = .;
 
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .cacheline_aligned.data : { *(.cacheline_aligned.data) }
 
   _edata  =  .;
   PROVIDE (edata = .);
 
   . = ALIGN(8192);
-  .data.init_task : { *(.data.init_task) }
+  .init_task.data : { *(.init_task.data) }
 
   NOTES
 
