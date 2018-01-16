Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:46805 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeAPAnj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:43:39 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 15 Jan 2018 18:40:01 -0600
Message-ID: <20180116004009.31036-14-ebiederm@xmission.com>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Subject: [PATCH 14/22] signal/powerpc: Remove redefinition of NSIGTRAP on powerpc
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180116004001.K85CHKL2KdTuqZbQm9TdLhOPwyndi2v5HbgTAykt8XU@z>

NSIGTRAP is 4 in the generic siginfo and powerpc just undefines
NSGTRAP and redefine it as 4.  That accomplishes nothing so remove
the duplication.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/include/uapi/asm/siginfo.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/siginfo.h b/arch/powerpc/include/uapi/asm/siginfo.h
index 444ca6c9989a..9f142451a01f 100644
--- a/arch/powerpc/include/uapi/asm/siginfo.h
+++ b/arch/powerpc/include/uapi/asm/siginfo.h
@@ -15,9 +15,6 @@
 
 #include <asm-generic/siginfo.h>
 
-#undef NSIGTRAP
-#define NSIGTRAP	4
-
 /*
  * SIGFPE si_codes
  */
-- 
2.14.1
