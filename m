Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31BBC433E6
	for <linux-arch@archiver.kernel.org>; Sat,  9 Jan 2021 06:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9289D23A69
	for <linux-arch@archiver.kernel.org>; Sat,  9 Jan 2021 06:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbhAIG4v (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 9 Jan 2021 01:56:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10565 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbhAIG4v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 01:56:51 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DCW1X08sczMFB1
        for <linux-arch@vger.kernel.org>; Sat,  9 Jan 2021 14:54:56 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 9 Jan 2021 14:56:02 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <arnd@arndb.de>, <yangerkun@huawei.com>
CC:     <linux-arch@vger.kernel.org>
Subject: [PATCH 2/2] syscalls: fix define file comments for lookup_dcookie
Date:   Sat, 9 Jan 2021 14:58:28 +0800
Message-ID: <20210109065828.1528262-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210109065828.1528262-1-yangerkun@huawei.com>
References: <20210109065828.1528262-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The define file for lookup_dcookie is fs/dcookies.c, not fs/cookies.c

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 include/uapi/asm-generic/unistd.h       | 2 +-
 tools/include/uapi/asm-generic/unistd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 84022c87ed49..9886ff3337df 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -74,7 +74,7 @@ __SYSCALL(__NR_fremovexattr, sys_fremovexattr)
 #define __NR_getcwd 17
 __SYSCALL(__NR_getcwd, sys_getcwd)
 
-/* fs/cookies.c */
+/* fs/dcookies.c */
 #define __NR_lookup_dcookie 18
 __SC_COMP(__NR_lookup_dcookie, sys_lookup_dcookie, compat_sys_lookup_dcookie)
 
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 84022c87ed49..9886ff3337df 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -74,7 +74,7 @@ __SYSCALL(__NR_fremovexattr, sys_fremovexattr)
 #define __NR_getcwd 17
 __SYSCALL(__NR_getcwd, sys_getcwd)
 
-/* fs/cookies.c */
+/* fs/dcookies.c */
 #define __NR_lookup_dcookie 18
 __SC_COMP(__NR_lookup_dcookie, sys_lookup_dcookie, compat_sys_lookup_dcookie)
 
-- 
2.25.4

