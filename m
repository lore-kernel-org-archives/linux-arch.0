Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759699AbeD1Mf1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Apr 2018 08:35:27 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 1/7] kprobes: Make list and blacklist root user read only
Date: Sat, 28 Apr 2018 21:35:01 +0900
Message-ID: <152491890171.9916.5183693615601334087.stgit@devbox>
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
Message-ID: <20180428123501.UpWTI7AMi2KzKSZcS4I5BUUqRH5S3LqkWg9HcqJa4n0@z>

Since the blacklist and list files on debugfs indicates
a sensitive address information to reader, it should be
restricted to the root user.

Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v4:
  - Fix "list" file's mode too.
---
 kernel/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ea619021d901..5eb42c82497c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2611,7 +2611,7 @@ static int __init debugfs_kprobe_init(void)
 	if (!dir)
 		return -ENOMEM;
 
-	file = debugfs_create_file("list", 0444, dir, NULL,
+	file = debugfs_create_file("list", 0400, dir, NULL,
 				&debugfs_kprobes_operations);
 	if (!file)
 		goto error;
@@ -2621,7 +2621,7 @@ static int __init debugfs_kprobe_init(void)
 	if (!file)
 		goto error;
 
-	file = debugfs_create_file("blacklist", 0444, dir, NULL,
+	file = debugfs_create_file("blacklist", 0400, dir, NULL,
 				&debugfs_kprobe_blacklist_ops);
 	if (!file)
 		goto error;
