Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x346.tv-sign.ru ([89.108.83.215]:38046 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758201AbYBWVD7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 23 Feb 2008 16:03:59 -0500
Date: Sun, 24 Feb 2008 00:03:29 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH, 3rd resend] documentation: atomic_add_unless() doesn't imply mb() on failure
Message-ID: <20080223210329.GA221@tv-sign.ru>
References: <200802230733.m1N7XnMu018253@imap1.linux-foundation.org> <20080223162705.GA7686@tv-sign.ru> <alpine.LFD.1.00.0802230937530.21332@woody.linux-foundation.org> <20080223182258.GA19946@tv-sign.ru> <alpine.LFD.1.00.0802231044240.21332@woody.linux-foundation.org> <b647ffbd0802231151w481fdcb5hc2a3972e7fd03f69@mail.gmail.com> <alpine.LFD.1.00.0802231202380.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802231202380.21332@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Adamushko <dmitry.adamushko@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, a.p.zijlstra@chello.nl, apw@shadowen.org, Ingo Molnar <mingo@elte.hu>, nickpiggin@yahoo.com.au, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

(sorry for being offtpoic, but while experts are here...)

A "typical" implementation of atomic_add_unless() can return 0 immediately
after the first atomic_read() (before doing cmpxchg). In that case it doesn't
provide any barrier semantics. See include/asm-ia64/atomic.h as an example.

We should either change the implementation, or fix the docs.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Acked-by: Nick Piggin <npiggin@suse.de>

 Documentation/atomic_ops.txt      |    3 ++-
 Documentation/memory-barriers.txt |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- t/Documentation/atomic_ops.txt~doc_aau	2008-01-14 23:43:11.000000000 +0300
+++ t/Documentation/atomic_ops.txt	2008-02-23 23:53:12.000000000 +0300
@@ -186,7 +186,8 @@ If the atomic value v is not equal to u,
 returns non zero. If v is equal to u then it returns zero. This is done as
 an atomic operation.
 
-atomic_add_unless requires explicit memory barriers around the operation.
+atomic_add_unless requires explicit memory barriers around the operation
+unless it fails (returns 0).
 
 atomic_inc_not_zero, equivalent to atomic_add_unless(v, 1, 0)
 
--- t/Documentation/memory-barriers.txt~doc_aau	2008-01-14 23:43:11.000000000 +0300
+++ t/Documentation/memory-barriers.txt	2008-02-23 23:53:12.000000000 +0300
@@ -1493,7 +1493,7 @@ explicit lock operations, described late
 	atomic_dec_and_test();
 	atomic_sub_and_test();
 	atomic_add_negative();
-	atomic_add_unless();
+	atomic_add_unless();	/* when succeeds (returns 1) */
 	test_and_set_bit();
 	test_and_clear_bit();
 	test_and_change_bit();

