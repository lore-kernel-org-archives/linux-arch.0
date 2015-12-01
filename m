From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] Kbuild: Enable interprocedural register allocation for gcc 5
Date: Mon, 30 Nov 2015 22:00:43 -0800
Message-ID: <1448949643-6059-1-git-send-email-andi@firstfloor.org>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: mmarek@suse.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

gcc 5 has a new -fipa-ra option that enables limited interprocedural
register allocation. When it generates a function it remembers
what registers it clobbered. Later when the function is called
it only saves registers that are actually clobbered by the function.

This only really works when caller and callee are in the same compilation unit
(except with LTO)

In principle this violates the ABI which specifies which registers
are saved and which are clobbered on a call. However there shouldn't
be anything else relying on this: while we have multiple subsystems
that patch binaries (like ftrace, kprobes) they all cannot know
which registers are used as arguments, so always need to save/restore
all registers.

Similarly gdb and other debuggers cannot rely on the ABI either.

It has some risk that it breaks something obscure, but so far I haven't
seen or found anything.

On my system with gcc 5.2 it saves about 40k in binary size

   text    data     bss     dec     hex filename
9583446 2178288 1675264 13436998         cd0846 vmlinux-base
9542180 2178096 1675264 13395540         cc6654 vmlinux-ipara   -0.4%

pretty much all in missing spill code. So it's not a dramatic win,
but still a nice improvement.

Open: for now I enabled it for all architectures, although it's
only tested on x86-64. It may be safer to move it to be x86
specific or guard with an CONFIG option, until more testing can be done.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 2ffdf9d..c95320f 100644
--- a/Makefile
+++ b/Makefile
@@ -626,6 +626,12 @@ KBUILD_CFLAGS += $(call cc-option,-fno-reorder-blocks,) \
                  $(call cc-option,-fno-partial-inlining)
 endif
 
+# Ask gcc to use interprocedural register allocation when possible.
+# This allows it to violate the callee-saved register ABI and avoid
+# generating register spills in the caller when it knows the function does
+# not clobber these registers
+KBUILD_CFLAGS += $(call cc-option,-fipa-ra,)
+
 ifneq ($(CONFIG_FRAME_WARN),0)
 KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
 endif
-- 
2.6.3

