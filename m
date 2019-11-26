From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix __percpu annotation in asm-generic
Date: Tue, 26 Nov 2019 21:06:19 +0100
Message-ID: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dennis Zhou <dennis@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

The generic implementation of raw_cpu_generic_add_return() is:

        #define raw_cpu_generic_add_return(pcp, val)            \
        ({                                                      \
                typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));       \
                                                                \
                *__p += val;                                    \
                *__p;                                           \
        })

where the 'pcp' argument is a __percpu lvalue.
There, the variable '__p' is declared as a __percpu pointer
the type of the address of 'pcp') but:
1) the value assigned to it, the return value of raw_cpu_ptr(), is
   a plain (__kernel) pointer, not a __percpu one.
2) the variable is dereferenced just after while a __percpu pointer
   is implicitly __noderef.

So, fix the declaration of the 'pcp' variable to its correct type:
the plain (non-percpu) pointer corresponding to its address.
Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
raw_cpu_generic_cmpxchg_double().

This remove 209 warnings on ARM, 460 on x86 & 2600+ on ppc64.

Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/asm-generic/percpu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index c2de013b2cf4..4ae5f89a0e61 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -74,7 +74,7 @@ do {									\
 
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) __kernel __force *__p = raw_cpu_ptr(&(pcp));	\
 									\
 	*__p += val;							\
 	*__p;								\
@@ -82,7 +82,7 @@ do {									\
 
 #define raw_cpu_generic_xchg(pcp, nval)					\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) __kernel __force *__p = raw_cpu_ptr(&(pcp));	\
 	typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	*__p = nval;							\
@@ -91,7 +91,7 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) __kernel __force *__p = raw_cpu_ptr(&(pcp));	\
 	typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	if (__ret == (oval))						\
@@ -101,8 +101,8 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 ({									\
-	typeof(&(pcp1)) __p1 = raw_cpu_ptr(&(pcp1));			\
-	typeof(&(pcp2)) __p2 = raw_cpu_ptr(&(pcp2));			\
+	typeof(pcp1) __kernel __force *__p1 = raw_cpu_ptr(&(pcp1));	\
+	typeof(pcp2) __kernel __force *__p2 = raw_cpu_ptr(&(pcp2));	\
 	int __ret = 0;							\
 	if (*__p1 == (oval1) && *__p2  == (oval2)) {			\
 		*__p1 = nval1;						\
-- 
2.24.0
