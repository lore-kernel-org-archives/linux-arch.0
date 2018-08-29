Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:52170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbeH2Qt2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 12:49:28 -0400
Date: Wed, 29 Aug 2018 20:50:52 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH] y2038: __get_old_timespec32() can be static
Message-ID: <20180829125052.GA114325@lkp-g5>
References: <20180827194531.3796559-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827194531.3796559-4-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, tglx@linutronix.de, y2038@lists.linaro.org, linux-api@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, deepa.kernel@gmail.com, linux-arch@vger.kernel.org
Message-ID: <20180829125052.n_5-M4RkdRS2ru0SADiGcVDjUqXTn_WMxwMweHVbZQ4@z>


Fixes: ee16c8f415e4 ("y2038: Globally rename compat_time to old_time32")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index f1983f4..e3a7f7f 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -863,7 +863,7 @@ int put_timespec64(const struct timespec64 *ts,
 }
 EXPORT_SYMBOL_GPL(put_timespec64);
 
-int __get_old_timespec32(struct timespec64 *ts64,
+static int __get_old_timespec32(struct timespec64 *ts64,
 				   const struct old_timespec32 __user *cts)
 {
 	struct old_timespec32 ts;
@@ -879,7 +879,7 @@ int __get_old_timespec32(struct timespec64 *ts64,
 	return 0;
 }
 
-int __put_old_timespec32(const struct timespec64 *ts64,
+static int __put_old_timespec32(const struct timespec64 *ts64,
 				   struct old_timespec32 __user *cts)
 {
 	struct old_timespec32 ts = {
