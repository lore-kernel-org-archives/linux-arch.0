From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 116/140] nospec: Include <asm/barrier.h> dependency
Date: Tue, 13 Mar 2018 16:25:19 +0100
Message-ID: <20180313152505.978882805@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Andy Lutomirski <luto@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nospec.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,7 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+#include <asm/barrier.h>
 
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
