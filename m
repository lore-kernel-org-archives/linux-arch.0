From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Fix ARM PIC problems with new decompressor code
Date: Sun, 28 Feb 2010 15:49:08 +0000
Message-ID: <20100228154908.GB11343@flint.arm.linux.org.uk>
References: <20100226081926.GA3511@flint.arm.linux.org.uk> <4B87907B.7080008@knaff.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44733 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968717Ab0B1Pt2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2010 10:49:28 -0500
Content-Disposition: inline
In-Reply-To: <4B87907B.7080008@knaff.lu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alain Knaff <alain@knaff.lu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org

On Fri, Feb 26, 2010 at 10:12:27AM +0100, Alain Knaff wrote:
> Yes, that should be fine. So it would be static in full kernel context
> (initrd decompression) but global in preboot. As long as it doesn't clash
> with other variables of the same name, but I think that's rather unlikely
> in the "small" preboot environment.

Here's a patch to this end.  I decided to change the name of the
define to something more sensible.

Are we happy with this?  Shall I queue it for merging?  I'd be nice
to get this into -stable as well as some other fixes for this feature.


Subject: Fix new decompressor for PIC

The ARM kernel decompressor wants to be able to relocate r/w data
independently from the rest of the image, and we do this by ensuring
that r/w data has global visibility.  Define STATIC_RW_DATA to be
empty to achieve this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
-- 
 include/linux/decompress/mm.h |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index 5032b9a..278e6c8 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -14,11 +14,21 @@
 
 /* Code active when included from pre-boot environment: */
 
+/*
+ * Some architectures want to ensure there is no local data in their
+ * pre-boot environment, so that data can arbitarily relocated (via
+ * GOT references).  This is achieved by defining STATIC_RW_DATA to
+ * be null.
+ */
+#ifndef STATIC_RW_DATA
+#define STATIC_RW_DATA static
+#endif
+
 /* A trivial malloc implementation, adapted from
  *  malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  */
-static unsigned long malloc_ptr;
-static int malloc_count;
+STATIC_RW_DATA unsigned long malloc_ptr;
+STATIC_RW_DATA int malloc_count;
 
 static void *malloc(int size)
 {


-- 
Russell King
