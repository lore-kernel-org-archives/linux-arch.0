Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34794 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbeLIVzO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Dec 2018 16:55:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.677950644@decadent.org.uk>
Subject: [PATCH 3.16 005/328] kprobes: Make list and blacklist root user
 read only
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, Jon Medhurst <tixy@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, rostedt@goodmis.org, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, brueckner@linux.vnet.ibm.com, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Tobin C . Harding" <me@tobin.cc>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S . Miller" <davem@davemloft.net>, acme@kernel.org, Ingo Molnar <mingo@kernel.org>
Message-ID: <20181209215033.ded7RWvqRIg0U_EUPZMwBNIFvhYyYioDo6Psdn5swBY@z>

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit f2a3ab36077222437b4826fc76111caa14562b7c upstream.

Since the blacklist and list files on debugfs indicates
a sensitive address information to reader, it should be
restricted to the root user.

Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jon Medhurst <tixy@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tobin C . Harding <me@tobin.cc>
Cc: Will Deacon <will.deacon@arm.com>
Cc: acme@kernel.org
Cc: akpm@linux-foundation.org
Cc: brueckner@linux.vnet.ibm.com
Cc: linux-arch@vger.kernel.org
Cc: rostedt@goodmis.org
Cc: schwidefsky@de.ibm.com
Link: https://lkml.kernel.org/lkml/152491890171.9916.5183693615601334087.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2414,7 +2414,7 @@ static int __init debugfs_kprobe_init(vo
 	if (!dir)
 		return -ENOMEM;
 
-	file = debugfs_create_file("list", 0444, dir, NULL,
+	file = debugfs_create_file("list", 0400, dir, NULL,
 				&debugfs_kprobes_operations);
 	if (!file)
 		goto error;
@@ -2424,7 +2424,7 @@ static int __init debugfs_kprobe_init(vo
 	if (!file)
 		goto error;
 
-	file = debugfs_create_file("blacklist", 0444, dir, NULL,
+	file = debugfs_create_file("blacklist", 0400, dir, NULL,
 				&debugfs_kprobe_blacklist_ops);
 	if (!file)
 		goto error;
