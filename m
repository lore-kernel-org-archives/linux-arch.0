Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.136]:35951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfBMIic (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 03:38:32 -0500
Date: Wed, 13 Feb 2019 00:38:21 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-728e3e6178aa5790066b642dd2ebc9e9bdacff1b@git.kernel.org>
Reply-To: arnd@arndb.de, linux-kernel@vger.kernel.org,
          linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
          paulmck@linux.ibm.com, hpa@zytor.com
Subject: [tip:core/rcu] include/asm-generic: Remove spin_is_locked() comment
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: linux-arch@vger.kernel.org, mingo@kernel.org, arnd@arndb.de, hpa@zytor.com, paulmck@linux.ibm.com, tglx@linutronix.de

Commit-ID:  728e3e6178aa5790066b642dd2ebc9e9bdacff1b
Gitweb:     https://git.kernel.org/tip/728e3e6178aa5790066b642dd2ebc9e9bdacff1b
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Tue, 8 Jan 2019 10:13:44 -0800
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Fri, 25 Jan 2019 15:36:04 -0800

include/asm-generic: Remove spin_is_locked() comment

The WARN_ON_SMP() comment header suggests using spin_is_locked() to
check for locks being held.  But these days we prefer lockdep_assert_held(),
so this commit removes that suggestion.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
---
 include/asm-generic/bug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..0e9bd9c83870 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -211,9 +211,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 /*
  * WARN_ON_SMP() is for cases that the warning is either
  * meaningless for !SMP or may even cause failures.
- * This is usually used for cases that we have
- * WARN_ON(!spin_is_locked(&lock)) checks, as spin_is_locked()
- * returns 0 for uniprocessor settings.
  * It can also be used with values that are only defined
  * on SMP:
  *
