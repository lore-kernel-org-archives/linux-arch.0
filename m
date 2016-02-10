From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 07/13] arm: move exports to definitions
Date: Wed, 10 Feb 2016 16:56:07 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1602101636250.17825@knanqh.ubzr>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
 <1454534445-16759-7-git-send-email-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:37463 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbcBJWLQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2016 17:11:16 -0500
In-reply-to: <1454534445-16759-7-git-send-email-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 3 Feb 2016, Al Viro wrote:

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

The following construct is incompatible with my autoksyms series:

> diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
> index 7d807cf..df06638 100644
> --- a/arch/arm/lib/bitops.h
> +++ b/arch/arm/lib/bitops.h
> @@ -1,5 +1,6 @@
>  #include <asm/assembler.h>
>  #include <asm/unwind.h>
> +#include <asm/export.h>
>  
>  #if __LINUX_ARM_ARCH__ >= 6
>  	.macro	bitop, name, instr
> @@ -25,6 +26,7 @@ UNWIND(	.fnstart	)
>  	bx	lr
>  UNWIND(	.fnend		)
>  ENDPROC(\name		)
> +EXPORT_SYMBOL(\name	)
>  	.endm

Here \name is an assembler macro argument and it is not subject to 
preprocessor substitutions.  And the assembler doesn't see preprocessor 
macros either.

So I'd suggest folding the following patch to let the preprocessor see 
the actual symbol name. It doesn't make the source code as compact but 
it works with my series.

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index df06638b32..7d807cfd8e 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -1,6 +1,5 @@
 #include <asm/assembler.h>
 #include <asm/unwind.h>
-#include <asm/export.h>
 
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, name, instr
@@ -26,7 +25,6 @@ UNWIND(	.fnstart	)
 	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 	.macro	testop, name, instr, store
@@ -57,7 +55,6 @@ UNWIND(	.fnstart	)
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #else
 	.macro	bitop, name, instr
@@ -77,7 +74,6 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 /**
@@ -106,6 +102,5 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #endif
diff --git a/arch/arm/lib/changebit.S b/arch/arm/lib/changebit.S
index f402786217..1cfdb138d2 100644
--- a/arch/arm/lib/changebit.S
+++ b/arch/arm/lib/changebit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 bitop	_change_bit, eor
+
+EXPORT_SYMBOL(_change_bit)
diff --git a/arch/arm/lib/clearbit.S b/arch/arm/lib/clearbit.S
index f6b75fb64d..e901ca5af0 100644
--- a/arch/arm/lib/clearbit.S
+++ b/arch/arm/lib/clearbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 bitop	_clear_bit, bic
+
+EXPORT_SYMBOL(_clear_bit)
diff --git a/arch/arm/lib/setbit.S b/arch/arm/lib/setbit.S
index 618fedae4b..3c8b11240f 100644
--- a/arch/arm/lib/setbit.S
+++ b/arch/arm/lib/setbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
 		.text
 
 bitop	_set_bit, orr
+
+EXPORT_SYMBOL(_set_bit)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4becdc3a59..e3d19b87fb 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_change_bit, eor, str
+
+EXPORT_SYMBOL(_test_and_change_bit)
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 918841dcce..d247e6f70f 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_clear_bit, bicne, strne
+
+EXPORT_SYMBOL(_test_and_clear_bit)
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index 8d1b2fe9e4..76800ff601 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_set_bit, orreq, streq
+
+EXPORT_SYMBOL(_test_and_set_bit)
