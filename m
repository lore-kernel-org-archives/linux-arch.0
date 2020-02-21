Return-Path: <SRS0=0XgO=4J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:56318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgBUNu1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:27 -0500
Message-ID: <20200221134216.573806438@infradead.org>
Date: Fri, 21 Feb 2020 14:34:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 22/27] compiler: Simple READ/WRITE_ONCE() implementations
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Message-ID: <20200221133438.lv2dgU3e3IyAZY25LWGQZAvtWkW0vzi0_xURc6j9Qeg@z>

Because I need WRITE_ONCE_NOCHECK() and in anticipation of Will's
READ_ONCE rewrite, provide __{READ,WRITE}_ONCE_SCALAR().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -289,6 +289,14 @@ unsigned long read_word_at_a_time(const
 	__u.__val;					\
 })
 
+#define __READ_ONCE_SCALAR(x)			\
+	(*(const volatile typeof(x) *)&(x))
+
+#define __WRITE_ONCE_SCALAR(x, val)		\
+do {						\
+	*(volatile typeof(x) *)&(x) = val;	\
+} while (0)
+
 #endif /* __KERNEL__ */
 
 /*
