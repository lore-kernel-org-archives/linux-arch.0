Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34864 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfBVMxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 07:53:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so2276853wrx.2
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 04:53:52 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 11/12] arm64: update Documentation/arm64/tagged-pointers.txt
Date: Fri, 22 Feb 2019 13:53:23 +0100
Message-ID: <e555d752859291bc74d550a5ea7e8ecd1876a308.1550839937.git.andreyknvl@google.com>
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>
Message-ID: <20190222125323.52Yc6ms6B063sYEE1U2illcAZKEwYXiKaHCm5W5BPLU@z>

Document the changes in Documentation/arm64/tagged-pointers.txt.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/arm64/tagged-pointers.txt | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..f4cf1f5cf362 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -17,13 +17,22 @@ this byte for application use.
 Passing tagged addresses to the kernel
 --------------------------------------
 
-All interpretation of userspace memory addresses by the kernel assumes
-an address tag of 0x00.
+The kernel supports tags in pointer arguments (including pointers in
+structures) for a limited set of syscalls, the exceptions are:
 
-This includes, but is not limited to, addresses found in:
+ - memory syscalls: brk, madvise, mbind, mincore, mlock, mlock2, move_pages,
+   mprotect, mremap, msync, munlock, munmap, pkey_mprotect, process_vm_readv,
+   process_vm_writev, remap_file_pages;
 
- - pointer arguments to system calls, including pointers in structures
-   passed to system calls,
+ - ioctls that accept user pointers that describe virtual memory ranges;
+
+ - TCP_ZEROCOPY_RECEIVE setsockopt.
+
+The kernel supports tags in user fault addresses. However the fault_address
+field in the sigcontext struct will contain an untagged address.
+
+All other interpretations of userspace memory addresses by the kernel
+assume an address tag of 0x00, in particular:
 
  - the stack pointer (sp), e.g. when interpreting it to deliver a
    signal,
@@ -33,11 +42,7 @@ This includes, but is not limited to, addresses found in:
 
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
2.21.0.rc0.258.g878e2cd30e-goog
