From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Mon, 17 Oct 2016 12:01:30 +0200
Message-ID: <20161017100130.GA16013@angband.pl>
References: <20161017065131.GA27863@angband.pl>
 <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 17, 2016 at 05:59:51PM +1100, Nicholas Piggin wrote:
> On Mon, 17 Oct 2016 08:51:31 +0200
> Adam Borowski <kilobyte@angband.pl> wrote:
> > On Mon, Oct 17, 2016 at 02:57:09PM +1100, Nicholas Piggin wrote:
> > > On Sat, 15 Oct 2016 17:22:05 -0700 Omar Sandoval <osandov@osandov.com> wrote:  
> > > > So this has broken all module loading for me. I get the following dmesg
> > > > spew:
> > > > ...
> > > > [    4.586914] scsi_mod: no symbol version for memset
> > > > [    4.587920] scsi_mod: Unknown symbol memset (err -22)
> > > > [    4.588443] scsi_mod: no symbol version for ___preempt_schedule
> > > > [    4.589026] scsi_mod: Unknown symbol ___preempt_schedule (err -22)
> > > > ...
> > > > 
> > > > Reverting 784d5699eddc ("x86: move exports to actual definitions") fixes
> > > > it for me. This is with GCC 6.2.1, binutils 2.27, attached config.  
> > > 
> > > Thanks for the report. Could you try this patch and see if it helps?  
> > [patch snipped]
> > 
> > Omar probably won't wake up in quite a while, so I've tested the patch.
> > Alas, doesn't help.  Similar spew (for the few modules I don't have =y),
> > while reverting 784d5699eddc fixes it for me too.
> 
> Forgot to engage my brain before posting.
> 
> Architectures will need to have an include/asm/asm-prototypes.h that
> defines or #include<>s C-style prototypes for exported asm functions.
> We can do an asm-generic version for the common ones like memset so
> there's not a lot of pointless duplication there.
> 
> Care to do a patch for x86?

Sure, did so.  With the prototypes added, your patch works!
Tested on a handful of modules, and one out-of-tree (virtualbox).
I didn't try a 32-bit build.

Note that powerpc already has an include/asm/asm-prototypes.h which might or
might not be what you want.  It doesn't have memset and co, for example.

Anyway, here's my stab at x86:


From db746df65b920591606398b4b244f5b6dc9eea04 Mon Sep 17 00:00:00 2001
From: Adam Borowski <kilobyte@angband.pl>
Date: Mon, 17 Oct 2016 11:42:35 +0200
Subject: [PATCH] kbuild: provide include/asm/asm-prototypes.h for x86

Nicholas Piggin wrote:
> Architectures will need to have an include/asm/asm-prototypes.h that
> defines or #include<>s C-style prototypes for exported asm functions.
> We can do an asm-generic version for the common ones like memset so
> there's not a lot of pointless duplication there.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/x86/include/asm/asm-prototypes.h | 13 +++++++++++++
 include/asm-generic/asm-prototypes.h  |  7 +++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/x86/include/asm/asm-prototypes.h
 create mode 100644 include/asm-generic/asm-prototypes.h

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
new file mode 100644
index 0000000..072c97c
--- /dev/null
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -0,0 +1,13 @@
+#include <asm/ftrace.h>
+#include <asm/uaccess.h>
+#include <asm/uaccess.h>
+#include <asm/string.h>
+#include <asm/page.h>
+#include <asm/checksum.h>
+
+#include <asm-generic/asm-prototypes.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/special_insns.h>
+#include <asm/preempt.h>
diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
new file mode 100644
index 0000000..df13637
--- /dev/null
+++ b/include/asm-generic/asm-prototypes.h
@@ -0,0 +1,7 @@
+#include <linux/bitops.h>
+extern void *__memset(void *, int, __kernel_size_t);
+extern void *__memcpy(void *, const void *, __kernel_size_t);
+extern void *__memmove(void *, const void *, __kernel_size_t);
+extern void *memset(void *, int, __kernel_size_t);
+extern void *memcpy(void *, const void *, __kernel_size_t);
+extern void *memmove(void *, const void *, __kernel_size_t);
-- 
2.9.3
