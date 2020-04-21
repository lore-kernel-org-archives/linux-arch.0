From: Will Deacon <will@kernel.org>
Subject: [PATCH v4 03/11] net: tls: Avoid assigning 'const' pointer to non-const pointer
Date: Tue, 21 Apr 2020 16:15:29 +0100
Message-ID: <20200421151537.19241-4-will@kernel.org>
References: <20200421151537.19241-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgDUPPy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 11:15:54 -0400
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Boris Pismenny <borisp@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, John Fastabend <john.fastabend@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>

tls_build_proto() uses WRITE_ONCE() to assign a 'const' pointer to a
'non-const' pointer. Cleanups to the implementation of WRITE_ONCE() mean
that this will give rise to a compiler warning, just like a plain old
assignment would do:

  | net/tls/tls_main.c: In function ‘tls_build_proto’:
  | ./include/linux/compiler.h:229:30: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  | net/tls/tls_main.c:640:4: note: in expansion of macro ‘smp_store_release’
  |   640 |    smp_store_release(&saved_tcpv6_prot, prot);
  |       |    ^~~~~~~~~~~~~~~~~

Drop the const qualifier from the local 'prot' variable, as it isn't
needed.

Cc: Boris Pismenny <borisp@mellanox.com>
Cc: Aviad Yehezkel <aviadye@mellanox.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/tls/tls_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 0e989005bdc2..ec10041c6b7d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -629,7 +629,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 static void tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
-	const struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct proto *prot = READ_ONCE(sk->sk_prot);
 
 	/* Build IPv6 TLS whenever the address of tcpv6 _prot changes */
 	if (ip_ver == TLSV6 &&
-- 
2.26.1.301.g55bc3eb7cb9-goog
