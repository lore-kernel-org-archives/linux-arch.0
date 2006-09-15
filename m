Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:6840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751425AbWIOBkg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Sep 2006 21:40:36 -0400
Message-Id: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Subject: [patch 1/1] make PROT_WRITE imply PROT_READ
From: akpm@osdl.org
Date: Thu, 14 Sep 2006 18:39:47 -0700
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org, jbaron@redhat.com, ak@muc.de, alan@lxorguk.ukuu.org.uk, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

From: Jason Baron <jbaron@redhat.com>

(akpm: needs to be split into nine patches and fed through arch trees. 
Later.)

(err, make it's easier to just collect some acks?)

Make PROT_WRITE imply PROT_READ for a number of architectures which don't
support write only in hardware.

While looking at this, I noticed that some architectures which do not
support write only mappings already take the exact same approach.  For
example, in arch/alpha/mm/fault.c:

"
        if (cause < 0) {
                if (!(vma->vm_flags & VM_EXEC))
                        goto bad_area;
        } else if (!cause) {
                /* Allow reads even for write-only mappings */
                if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
                        goto bad_area;
        } else {
                if (!(vma->vm_flags & VM_WRITE))
                        goto bad_area;
        }
"

Thus, this patch brings other architectures which do not support write only
mappings in-line and consistent with the rest.  I've verified the patch on
ia64, x86_64 and x86.


Additional discussion:

Several architectures, including x86, can not support write-only mappings. 
The pte for x86 reserves a single bit for protection and its two states are
read only or read/write.  Thus, write only is not supported in h/w.  

Currently, if i 'mmap' a page write-only, the first read attempt on that page
creates a page fault and will SEGV.  That check is enforced in
arch/blah/mm/fault.c.  However, if i first write that page it will fault in
and the pte will be set to read/write.  Thus, any subsequent reads to the page
will succeed.  It is this inconsistency in behavior that this patch is
attempting to address.  Furthermore, if the page is swapped out, and then
brought back the first read will also cause a SEGV.  Thus, any arbitrary read
on a page can potentially result in a SEGV.

According to the SuSv3 spec, "if the application requests only PROT_WRITE, the
implementation may also allow read access." Also as mentioned, some
archtectures, such as alpha, shown above already take the approach that i am
suggesting.

The counter-argument to this raised by Arjan, is that the kernel is enforcing
the write only mapping the best it can given the h/w limitations.  This is
true, however Alan Cox, and myself would argue that the inconsitency in
behavior, that is applications can sometimes work/sometimes fails is highly
undesireable.  If you read through the thread, i think people, came to an
agreement on the last patch i posted, as nobody has objected to it...

Signed-off-by: Jason Baron <jbaron@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Kazumoto Kojima <kkojima@rr.iij4u.or.jp>
Cc: Ian Molton <spyro@f2s.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/arm/mm/fault.c     |    2 +-
 arch/arm26/mm/fault.c   |    2 +-
 arch/i386/mm/fault.c    |    2 +-
 arch/ia64/mm/fault.c    |    6 ++++--
 arch/m68k/mm/fault.c    |    2 +-
 arch/powerpc/mm/fault.c |    2 +-
 arch/ppc/mm/fault.c     |    2 +-
 arch/sh/mm/fault.c      |    2 +-
 arch/x86_64/mm/fault.c  |    2 +-
 9 files changed, 12 insertions(+), 10 deletions(-)

diff -puN arch/arm/mm/fault.c~make-prot_write-imply-prot_read arch/arm/mm/fault.c
--- a/arch/arm/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/arm/mm/fault.c
@@ -170,7 +170,7 @@ good_area:
 	if (fsr & (1 << 11)) /* write? */
 		mask = VM_WRITE;
 	else
-		mask = VM_READ|VM_EXEC;
+		mask = VM_READ|VM_EXEC|VM_WRITE;
 
 	fault = VM_FAULT_BADACCESS;
 	if (!(vma->vm_flags & mask))
diff -puN arch/arm26/mm/fault.c~make-prot_write-imply-prot_read arch/arm26/mm/fault.c
--- a/arch/arm26/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/arm26/mm/fault.c
@@ -155,7 +155,7 @@ __do_page_fault(struct mm_struct *mm, un
 	 */
 good_area:
 	if (READ_FAULT(fsr)) /* read? */
-		mask = VM_READ|VM_EXEC;
+		mask = VM_READ|VM_EXEC|VM_WRITE;
 	else
 		mask = VM_WRITE;
 
diff -puN arch/i386/mm/fault.c~make-prot_write-imply-prot_read arch/i386/mm/fault.c
--- a/arch/i386/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/i386/mm/fault.c
@@ -440,7 +440,7 @@ good_area:
 		case 1:		/* read, present */
 			goto bad_area;
 		case 0:		/* read, not present */
-			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 				goto bad_area;
 	}
 
diff -puN arch/ia64/mm/fault.c~make-prot_write-imply-prot_read arch/ia64/mm/fault.c
--- a/arch/ia64/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/ia64/mm/fault.c
@@ -146,9 +146,11 @@ ia64_do_page_fault (unsigned long addres
 #		error File is out of sync with <linux/mm.h>.  Please update.
 #	endif
 
+	if (((isr >> IA64_ISR_R_BIT) & 1UL) && (!(vma->vm_flags & (VM_READ | VM_WRITE))))
+		goto bad_area;
+
 	mask = (  (((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
-		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT)
-		| (((isr >> IA64_ISR_R_BIT) & 1UL) << VM_READ_BIT));
+		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT));
 
 	if ((vma->vm_flags & mask) != mask)
 		goto bad_area;
diff -puN arch/m68k/mm/fault.c~make-prot_write-imply-prot_read arch/m68k/mm/fault.c
--- a/arch/m68k/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/m68k/mm/fault.c
@@ -144,7 +144,7 @@ good_area:
 		case 1:		/* read, present */
 			goto acc_err;
 		case 0:		/* read, not present */
-			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 				goto acc_err;
 	}
 
diff -puN arch/powerpc/mm/fault.c~make-prot_write-imply-prot_read arch/powerpc/mm/fault.c
--- a/arch/powerpc/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/powerpc/mm/fault.c
@@ -333,7 +333,7 @@ good_area:
 		/* protection fault */
 		if (error_code & 0x08000000)
 			goto bad_area;
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
 	}
 
diff -puN arch/ppc/mm/fault.c~make-prot_write-imply-prot_read arch/ppc/mm/fault.c
--- a/arch/ppc/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/ppc/mm/fault.c
@@ -239,7 +239,7 @@ good_area:
 		/* protection fault */
 		if (error_code & 0x08000000)
 			goto bad_area;
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
 	}
 
diff -puN arch/sh/mm/fault.c~make-prot_write-imply-prot_read arch/sh/mm/fault.c
--- a/arch/sh/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/sh/mm/fault.c
@@ -80,7 +80,7 @@ good_area:
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
 	}
 
diff -puN arch/x86_64/mm/fault.c~make-prot_write-imply-prot_read arch/x86_64/mm/fault.c
--- a/arch/x86_64/mm/fault.c~make-prot_write-imply-prot_read
+++ a/arch/x86_64/mm/fault.c
@@ -464,7 +464,7 @@ good_area:
 		case PF_PROT:		/* read, present */
 			goto bad_area;
 		case 0:			/* read, not present */
-			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 				goto bad_area;
 	}
 
_
