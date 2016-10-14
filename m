Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arcturus.aphlor.org ([188.246.204.175]:47230 "EHLO
        arcturus.aphlor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbcJNS0j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2016 14:26:39 -0400
Date: Fri, 14 Oct 2016 14:26:24 -0400
From: Dave Jones <davej@codemonkey.org.uk>
Subject: pkeys: Remove easily triggered WARN
Message-ID: <20161014182624.4yzw36n4hd7x56wi@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-arch@vger.kernel.org, Dave Hansen <dave@sr71.net>, mgorman@techsingularity.net, arnd@arndb.de, linux-api@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
Message-ID: <20161014182624.74VaWVFJwJyXL5UUZx-QDytrwObPWEDH3fql-m2ikmI@z>

This easy-to-trigger warning shows up instantly when running
Trinity on a kernel with CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS disabled.

At most this should have been a printk, but the -EINVAL alone should be more
than adequate indicator that something isn't available.

Signed-off-by: Dave Jones <davej@codemonkey.org.uk>

diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index e4c08c1ff0c5..a1bacf1150b2 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -25,7 +25,6 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
 
 static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
-	WARN_ONCE(1, "free of protection key when disabled");
 	return -EINVAL;
 }
 
