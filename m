Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35955 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeJBT4O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 15:56:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so2179296wrw.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Oct 2018 06:12:57 -0700 (PDT)
From: Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v7 7/8] arm64: update Documentation/arm64/tagged-pointers.txt
Date: Tue,  2 Oct 2018 15:12:42 +0200
Message-ID: <47a464307d4df3c0cb65f88d1fe83f9a741dd74b.1538485901.git.andreyknvl@google.com>
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Andrey Konovalov <andreyknvl@google.com>
Message-ID: <20181002131242.uWPEmXTFCZwOY2sryRF3sNscRLFNJvCXV9_ag16HVPY@z>

Document the changes in Documentation/arm64/tagged-pointers.txt.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/arm64/tagged-pointers.txt | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..ae877d185fdb 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -17,13 +17,21 @@ this byte for application use.
 Passing tagged addresses to the kernel
 --------------------------------------
 
-All interpretation of userspace memory addresses by the kernel assumes
-an address tag of 0x00.
+Some initial work for supporting non-zero address tags passed to the
+kernel has been done. As of now, the kernel supports tags in:
 
-This includes, but is not limited to, addresses found in:
+  - user fault addresses
 
- - pointer arguments to system calls, including pointers in structures
-   passed to system calls,
+  - pointer arguments (including pointers in structures), which don't
+    describe virtual memory ranges, passed to system calls
+
+All other interpretations of userspace memory addresses by the kernel
+assume an address tag of 0x00. This includes, but is not limited to,
+addresses found in:
+
+ - pointer arguments (including pointers in structures), which describe
+   virtual memory ranges, passed to memory system calls (mmap, mprotect,
+   etc.)
 
  - the stack pointer (sp), e.g. when interpreting it to deliver a
    signal,
@@ -33,11 +41,7 @@ This includes, but is not limited to, addresses found in:
 
 Using non-zero address tags in any of these locations may result in an
 error code being returned, a (fatal) signal being raised, or other modes
-of failure.
-
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
-strongly discouraged.
+of failure. Using a non-zero address tag for sp is strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
 address tags may suffer impaired or inaccurate debug and profiling
-- 
2.19.0.605.g01d371f741-goog
