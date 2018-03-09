From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 2/6] arm64: untag user addresses in copy_from_user
 and others
Date: Fri, 9 Mar 2018 15:58:29 +0000
Message-ID: <20180309155829.2fzgevhsxj3gnyly@armageddon.cambridge.arm.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <d681c0dee907ee5cc55d313e2f843237c6087bf0.1520600533.git.andreyknvl@google.com>
 <20180309150309.4sue2zj6teehx6e3@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309150309.4sue2zj6teehx6e3@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 09, 2018 at 03:03:09PM +0000, Mark Rutland wrote:
> On Fri, Mar 09, 2018 at 03:02:00PM +0100, Andrey Konovalov wrote:
> > copy_from_user (and a few other similar functions) are used to copy data
> > from user memory into the kernel memory or vice versa. Since a user can
> > provided a tagged pointer to one of the syscalls that use copy_from_user,
> > we need to correctly handle such pointers.
> 
> I don't think it makes sense to do this in the low-level uaccess
> primitives, given we're going to have to untag pointers before common
> code can use them, e.g. for comparisons against TASK_SIZE or
> user_addr_max().
> 
> I think we'll end up with subtle bugs unless we consistently untag
> pointers before we get to uaccess primitives. If core code does untag
> pointers, then it's redundant to do so here.

A quick "hack" below clears the tag on syscall entry (where the argument
is a __user pointer). However, we still have cases in core code where
the pointer is read from a structure or even passed as an unsigned long
as part of a command + argument (like in ptrace).

The "hack":

---------------------------------8<--------------------------
From 6df503651f73c923d91eb695e56f977ddcc52d43 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 6 Feb 2018 17:54:05 +0000
Subject: [PATCH] arm64: Allow user pointer tags to be passed into the kernel

The current tagged pointer ABI disallows the top byte of a user pointer
to be non-zero when invoking a syscall. This patch allows such pointer
to be passed into the kernel and the kernel will mask them out
automatically. Page-based syscall ABI (mmap, mprotect, madvise etc.)
expect the pointer tag to be 0 (see include/linux/syscalls.h for the ABI
functions taking __user pointers).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/unistd.h | 9 +++++++++
 include/linux/syscalls.h        | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a0baa9af5487..cd68ad969e3a 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -53,3 +53,12 @@
 #endif
 
 #define NR_syscalls (__NR_syscalls)
+
+/* copied from arch/s390/ */
+#define __TYPE_IS_PTR(t) (!__builtin_types_compatible_p( \
+				typeof(0?(__force t)0:0ULL), u64))
+/* sign-extend bit 55 to mask out the pointer tag */
+#define __SC_CAST(t, a)						\
+	(__TYPE_IS_PTR(t)					\
+		? (__force t)((__s64)((__u64)a << 8) >> 8)	\
+		: (__force t)a)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a78186d826d7..279497207a31 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -105,7 +105,9 @@ union bpf_attr;
 #define __TYPE_IS_UL(t)	(__TYPE_AS(t, 0UL))
 #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
 #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
+#ifndef __SC_CAST
 #define __SC_CAST(t, a)	(__force t) a
+#endif
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
 
-- 
Catalin
