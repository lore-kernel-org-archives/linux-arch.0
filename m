From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.16 70/76] nospec: Include <asm/barrier.h> dependency
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.664773192@decadent.org.uk>
References: <lsq.1520823971.5976735@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Andy Lutomirski <luto@kernel.org>, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit eb6174f6d1be16b19cfa43dac296bfed003ce1a6 upstream.

The nospec.h header expects the per-architecture header file
<asm/barrier.h> to optionally define array_index_mask_nospec(). Include
that dependency to prevent inadvertent fallback to the default
array_index_mask_nospec() implementation.

The default implementation may not provide a full mitigation
on architectures that perform data value speculation.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/151881605404.17395.1341935530792574707.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/nospec.h | 1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,7 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+#include <asm/barrier.h>
 
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
