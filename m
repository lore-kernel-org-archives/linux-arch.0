From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Subject: [tip:timers/core] arch: Remove stub cputime.h headers
Date: Wed, 12 Mar 2014 03:46:28 -0700
Message-ID: <tip-4e76436cce62144686638b638d0708aac8ac5a58@git.kernel.org>
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
	  peterz@infradead.org, riel@redhat.com, fweisbec@gmail.com,
	  mtosatti@redhat.com, tglx@linutronix.de,
	  linux-arch@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49342 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbaCLKrG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Mar 2014 06:47:06 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: hpa@zytor.com, mingo@kernel.org, peterz@infradead.org, riel@redhat.com, fweisbec@gmail.com, mtosatti@redhat.com, tglx@linutronix.de, linux-arch@vger.kernel.org

Commit-ID:  4e76436cce62144686638b638d0708aac8ac5a58
Gitweb:     http://git.kernel.org/tip/4e76436cce62144686638b638d0708aac8ac5a58
Author:     Frederic Weisbecker <fweisbec@gmail.com>
AuthorDate: Wed, 5 Mar 2014 17:24:12 +0100
Committer:  Frederic Weisbecker <fweisbec@gmail.com>
CommitDate: Wed, 12 Mar 2014 02:31:40 +0100

arch: Remove stub cputime.h headers

Many architectures have a stub cputime.h that only include the default
cputime.h

Lets remove the useless headers, we only need to mention that we want
the default headers on the Kbuild files.

Cc: Archs <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
---
 arch/alpha/include/asm/Kbuild         | 1 +
 arch/alpha/include/asm/cputime.h      | 6 ------
 arch/cris/include/asm/Kbuild          | 1 +
 arch/cris/include/asm/cputime.h       | 6 ------
 arch/frv/include/asm/Kbuild           | 1 +
 arch/frv/include/asm/cputime.h        | 6 ------
 arch/m32r/include/asm/Kbuild          | 1 +
 arch/m32r/include/asm/cputime.h       | 6 ------
 arch/microblaze/include/asm/Kbuild    | 1 +
 arch/microblaze/include/asm/cputime.h | 1 -
 arch/mn10300/include/asm/Kbuild       | 1 +
 arch/mn10300/include/asm/cputime.h    | 1 -
 arch/score/include/asm/Kbuild         | 2 +-
 arch/score/include/asm/cputime.h      | 6 ------
 arch/x86/include/asm/Kbuild           | 1 +
 arch/x86/include/asm/cputime.h        | 1 -
 16 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index a73a8e2..1a81a8b 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += exec.h
 generic-y += trace_clock.h
 generic-y += preempt.h
 generic-y += hash.h
+generic-y += cputime.h
\ No newline at end of file
diff --git a/arch/alpha/include/asm/cputime.h b/arch/alpha/include/asm/cputime.h
deleted file mode 100644
index 19577fd..0000000
--- a/arch/alpha/include/asm/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ALPHA_CPUTIME_H
-#define __ALPHA_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* __ALPHA_CPUTIME_H */
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index f3fd876..9d02b45 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -14,3 +14,4 @@ generic-y += trace_clock.h
 generic-y += vga.h
 generic-y += xor.h
 generic-y += preempt.h
+generic-y += cputime.h
\ No newline at end of file
diff --git a/arch/cris/include/asm/cputime.h b/arch/cris/include/asm/cputime.h
deleted file mode 100644
index 4446a65..0000000
--- a/arch/cris/include/asm/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __CRIS_CPUTIME_H
-#define __CRIS_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* __CRIS_CPUTIME_H */
diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
index bc42f14..c5eca98 100644
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -4,3 +4,4 @@ generic-y += exec.h
 generic-y += trace_clock.h
 generic-y += preempt.h
 generic-y += hash.h
+generic-y += cputime.h
diff --git a/arch/frv/include/asm/cputime.h b/arch/frv/include/asm/cputime.h
deleted file mode 100644
index f6c373a..0000000
--- a/arch/frv/include/asm/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_CPUTIME_H
-#define _ASM_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* _ASM_CPUTIME_H */
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index 932435a..fda061d 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += module.h
 generic-y += trace_clock.h
 generic-y += preempt.h
 generic-y += hash.h
+generic-y += cputime.h
\ No newline at end of file
diff --git a/arch/m32r/include/asm/cputime.h b/arch/m32r/include/asm/cputime.h
deleted file mode 100644
index 0a47550..0000000
--- a/arch/m32r/include/asm/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __M32R_CPUTIME_H
-#define __M32R_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* __M32R_CPUTIME_H */
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 2b98bc7..da88738a 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y += hash.h
 generic-y += trace_clock.h
 generic-y += syscalls.h
 generic-y += preempt.h
+generic-y += cputime.h
diff --git a/arch/microblaze/include/asm/cputime.h b/arch/microblaze/include/asm/cputime.h
deleted file mode 100644
index 6d68ad7..0000000
--- a/arch/microblaze/include/asm/cputime.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/cputime.h>
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbuild
index 992e989..e076269 100644
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += exec.h
 generic-y += hash.h
 generic-y += trace_clock.h
 generic-y += preempt.h
+generic-y += cputime.h
\ No newline at end of file
diff --git a/arch/mn10300/include/asm/cputime.h b/arch/mn10300/include/asm/cputime.h
deleted file mode 100644
index 6d68ad7..0000000
--- a/arch/mn10300/include/asm/cputime.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/cputime.h>
diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
index 146b9d5..1274e7a 100644
--- a/arch/score/include/asm/Kbuild
+++ b/arch/score/include/asm/Kbuild
@@ -7,4 +7,4 @@ generic-y += hash.h
 generic-y += trace_clock.h
 generic-y += xor.h
 generic-y += preempt.h
-
+generic-y += cputime.h
diff --git a/arch/score/include/asm/cputime.h b/arch/score/include/asm/cputime.h
deleted file mode 100644
index 1fced99..0000000
--- a/arch/score/include/asm/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_SCORE_CPUTIME_H
-#define _ASM_SCORE_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* _ASM_SCORE_CPUTIME_H */
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 7f66985..875f34e 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -5,3 +5,4 @@ genhdr-y += unistd_64.h
 genhdr-y += unistd_x32.h
 
 generic-y += clkdev.h
+generic-y += cputime.h
diff --git a/arch/x86/include/asm/cputime.h b/arch/x86/include/asm/cputime.h
deleted file mode 100644
index 6d68ad7..0000000
--- a/arch/x86/include/asm/cputime.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/cputime.h>
