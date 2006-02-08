Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18300
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1161088AbWBHQLC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Feb 2006 11:11:02 -0500
Message-Id: <43EA2641.76F0.0078.0@novell.com>
Date: Wed, 08 Feb 2006 17:11:30 +0100
From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: Fw: [PATCH] abstract type/size specification for assembly
References: <20060131143149.35db2e02.akpm@osdl.org>  <200602010836.09932.ak@suse.de> <20060201083243.GB24893@flint.arm.linux.org.uk>
In-Reply-To: <20060201083243.GB24893@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartFBD95F22.4__="
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartFBD95F22.4__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached an updated patch.

>>> Russell King <rmk@arm.linux.org.uk> 01.02.06 09:32:43 >>>
On Wed, Feb 01, 2006 at 08:36:09AM +0100, Andi Kleen wrote:
> On Tuesday 31 January 2006 23:31, Andrew Morton wrote:
> > 
> > OK?
> 
> Yes.

No.

> > +#define ENDPROC(name) \
> > +  .type name, @function; \
> > +  END(name)
> > +#define END(name) \
> > +  .size name, .-name

@ is the comment character on ARM, so this can't go here - we use

	.type name, %function

instead.  Interestingly, the info pages for as seem to indicate that
there's a number of alternatives - maybe the most benign one should
be used, iow:

	.type name, "function"

or alternatively make ENDPROC arch-overridable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/ 
 maintainer of:  2.6 Serial core

--=__PartFBD95F22.4__=
Content-Type: text/plain; name="linux-2.6.16-rc2-end-endproc.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.16-rc2-end-endproc.patch"

From: Jan Beulich <jbeulich@novell.com>

Updated patch, to provide abstraction for generating type and size information
of assembly routines and data, while permitting architectures to override
these defaults.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc2/include/asm-ia64/linkage.h 2.6.16-rc2-end-endproc/include/asm-ia64/linkage.h
--- /home/jbeulich/tmp/linux-2.6.16-rc2/include/asm-ia64/linkage.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc2-end-endproc/include/asm-ia64/linkage.h	2006-02-06 12:00:44.000000000 +0100
@@ -1,6 +1,14 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
+#ifndef __ASSEMBLY__
+
 #define asmlinkage CPP_ASMLINKAGE __attribute__((syscall_linkage))
 
+#else
+
+#include <asm/asmmacro.h>
+
+#endif
+
 #endif
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc2/include/asm-mips/linkage.h 2.6.16-rc2-end-endproc/include/asm-mips/linkage.h
--- /home/jbeulich/tmp/linux-2.6.16-rc2/include/asm-mips/linkage.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc2-end-endproc/include/asm-mips/linkage.h	2006-02-06 12:01:44.000000000 +0100
@@ -1,6 +1,8 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
-/* Nothing to see here... */
+#ifdef __ASSEMBLY__
+#include <asm/asm.h>
+#endif
 
 #endif
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc2/include/asm-v850/linkage.h 2.6.16-rc2-end-endproc/include/asm-v850/linkage.h
--- /home/jbeulich/tmp/linux-2.6.16-rc2/include/asm-v850/linkage.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc2-end-endproc/include/asm-v850/linkage.h	2006-02-06 12:03:21.000000000 +0100
@@ -1,6 +1,8 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
-/* Nothing to see here... */
+#ifdef __ASSEMBLY__
+#include <asm/asm.h>
+#endif
 
 #endif
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc2/include/linux/linkage.h 2.6.16-rc2-end-endproc/include/linux/linkage.h
--- /home/jbeulich/tmp/linux-2.6.16-rc2/include/linux/linkage.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc2-end-endproc/include/linux/linkage.h	2006-02-06 12:04:32.000000000 +0100
@@ -28,17 +28,27 @@
 #define ALIGN __ALIGN
 #define ALIGN_STR __ALIGN_STR
 
+#ifndef ENTRY
 #define ENTRY(name) \
   .globl name; \
   ALIGN; \
   name:
+#endif
 
 #define KPROBE_ENTRY(name) \
   .section .kprobes.text, "ax"; \
-  .globl name; \
-  ALIGN; \
-  name:
+  ENTRY(name)
 
+#ifndef END
+#define END(name) \
+  .size name, .-name
+#endif
+
+#ifndef ENDPROC
+#define ENDPROC(name) \
+  .type name, @function; \
+  END(name)
+#endif
 
 #endif
 

--=__PartFBD95F22.4__=--
