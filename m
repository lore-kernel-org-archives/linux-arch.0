Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25399 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCGQqy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Mar 2019 11:46:54 -0500
Date: Thu, 7 Mar 2019 17:46:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] signal: fix building with clang
Message-ID: <20190307164647.GC25101@redhat.com>
References: <20190307091218.2343836-1-arnd@arndb.de>
 <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
Message-ID: <20190307164648.Wmkm-uPpHZtlOIML8mayy1AMZg4wowi2X4JCKtR5ffs@z>

On 03/07, Arnd Bergmann wrote:
>
> We could use % everywhere,

Yes.

But again, why not simply use the "for (;;)" loops? Why we can't kill the
supid switch(_NSIG_WORDS) tricks altogether?

Oleg.

--- x/include/linux/signal.h
+++ x/include/linux/signal.h
@@ -121,26 +121,9 @@
 #define _SIG_SET_BINOP(name, op)					\
 static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
 {									\
-	unsigned long a0, a1, a2, a3, b0, b1, b2, b3;			\
-									\
-	switch (_NSIG_WORDS) {						\
-	case 4:								\
-		a3 = a->sig[3]; a2 = a->sig[2];				\
-		b3 = b->sig[3]; b2 = b->sig[2];				\
-		r->sig[3] = op(a3, b3);					\
-		r->sig[2] = op(a2, b2);					\
-		/* fall through */					\
-	case 2:								\
-		a1 = a->sig[1]; b1 = b->sig[1];				\
-		r->sig[1] = op(a1, b1);					\
-		/* fall through */					\
-	case 1:								\
-		a0 = a->sig[0]; b0 = b->sig[0];				\
-		r->sig[0] = op(a0, b0);					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
+	int i;								\
+	for (i = 0; i < ARRAY_SIZE(r->sig); ++i)			\
+		r->sig[i] = op(a->sig[i], b->sig[i]);			\
 }
 
 #define _sig_or(x,y)	((x) | (y))
