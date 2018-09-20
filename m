From: Vincent Chen <vincentc@andestech.com>
Subject: [PATCH 4/5] math-emu/op-2.h: Use statement expressions to prevent negative constant shift
Date: Thu, 20 Sep 2018 10:46:21 +0800
Message-ID: <1537411582-23723-5-git-send-email-vincentc@andestech.com>
References: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, deanbo422@gmail.com, vincentc@andestech.com
List-Id: linux-arch.vger.kernel.org

 This modification is quoted from glibc 'commit
<sysdeps/unix/sysv/linux/sparc/sparc64/dl-procinfo.c: Moved to>
(fe0b1e854ad32a69b260)'

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 include/math-emu/op-2.h |   97 ++++++++++++++++++++++------------------------
 1 files changed, 46 insertions(+), 51 deletions(-)

diff --git a/include/math-emu/op-2.h b/include/math-emu/op-2.h
index 4f26ecc..13a374f 100644
--- a/include/math-emu/op-2.h
+++ b/include/math-emu/op-2.h
@@ -31,61 +31,56 @@
 #define _FP_FRAC_HIGH_2(X)	(X##_f1)
 #define _FP_FRAC_LOW_2(X)	(X##_f0)
 #define _FP_FRAC_WORD_2(X,w)	(X##_f##w)
+#define _FP_FRAC_SLL_2(X, N) (						       \
+	(void) (((N) < _FP_W_TYPE_SIZE)					       \
+	  ? ({								       \
+		if (__builtin_constant_p(N) && (N) == 1) {		       \
+			X##_f1 = X##_f1 + X##_f1 +			       \
+				(((_FP_WS_TYPE) (X##_f0)) < 0);		       \
+			X##_f0 += X##_f0;				       \
+		} else {						       \
+			X##_f1 = X##_f1 << (N) | X##_f0 >>		       \
+						(_FP_W_TYPE_SIZE - (N));       \
+			X##_f0 <<= (N);					       \
+		}							       \
+		0;							       \
+	    })								       \
+	  : ({								       \
+	      X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);		       \
+	      X##_f0 = 0;						       \
+	  })))
+
+
+#define _FP_FRAC_SRL_2(X, N) (						       \
+	(void) (((N) < _FP_W_TYPE_SIZE)					       \
+	  ? ({								       \
+	      X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N));      \
+	      X##_f1 >>= (N);						       \
+	    })								       \
+	  : ({								       \
+	      X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);		       \
+	      X##_f1 = 0;						       \
+	    })))
 
-#define _FP_FRAC_SLL_2(X,N)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	if (__builtin_constant_p(N) && (N) == 1) 			\
-	  {								\
-	    X##_f1 = X##_f1 + X##_f1 + (((_FP_WS_TYPE)(X##_f0)) < 0);	\
-	    X##_f0 += X##_f0;						\
-	  }								\
-	else								\
-	  {								\
-	    X##_f1 = X##_f1 << (N) | X##_f0 >> (_FP_W_TYPE_SIZE - (N));	\
-	    X##_f0 <<= (N);						\
-	  }								\
-      }									\
-    else								\
-      {									\
-	X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);			\
-	X##_f0 = 0;							\
-      }									\
-  } while (0)
-
-#define _FP_FRAC_SRL_2(X,N)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
-      {									\
-	X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);			\
-	X##_f1 = 0;							\
-      }									\
-  } while (0)
 
 /* Right shift with sticky-lsb.  */
-#define _FP_FRAC_SRS_2(X,N,sz)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N) |	\
-		  (__builtin_constant_p(N) && (N) == 1			\
-		   ? X##_f0 & 1						\
-		   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
-      {									\
-	X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE) |			\
-		(((X##_f1 << (2*_FP_W_TYPE_SIZE - (N))) | X##_f0) != 0)); \
-	X##_f1 = 0;							\
-      }									\
-  } while (0)
+#define _FP_FRAC_SRS_2(X, N, sz) (					       \
+	(void) (((N) < _FP_W_TYPE_SIZE)					       \
+	  ? ({								       \
+	      X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N)      \
+			| (__builtin_constant_p(N) && (N) == 1		       \
+			   ? X##_f0 & 1					       \
+			   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0));       \
+		X##_f1 >>= (N);						       \
+	    })								       \
+	  : ({								       \
+	      X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE)		       \
+			| ((((N) == _FP_W_TYPE_SIZE			       \
+			     ? 0					       \
+			     : (X##_f1 << (2*_FP_W_TYPE_SIZE - (N))))          \
+			    | X##_f0) != 0));				       \
+	      X##_f1 = 0;						       \
+	    })))
 
 #define _FP_FRAC_ADDI_2(X,I)	\
   __FP_FRAC_ADDI_2(X##_f1, X##_f0, I)
-- 
1.7.1
