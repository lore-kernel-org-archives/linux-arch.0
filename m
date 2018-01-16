From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 19/22] signal/blackfin: Remove pointless UID16_SIGINFO_COMPAT_NEEDED
Date: Mon, 15 Jan 2018 18:40:06 -0600
Message-ID: <20180116004009.31036-19-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:48389 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeAPAni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:43:38 -0500
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

Nothing tests this define so just remove it.

I suspect the intention was to make the uid field in siginfo 16bit
however I can't find any code that ever tested this defined, and
even if it did it the layout has been this way for 8 years so
changing it now would break the ABI with userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/blackfin/include/uapi/asm/siginfo.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/blackfin/include/uapi/asm/siginfo.h b/arch/blackfin/include/uapi/asm/siginfo.h
index 8c505170f4d0..2dd8c9c39248 100644
--- a/arch/blackfin/include/uapi/asm/siginfo.h
+++ b/arch/blackfin/include/uapi/asm/siginfo.h
@@ -11,8 +11,6 @@
 #include <linux/types.h>
 #include <asm-generic/siginfo.h>
 
-#define UID16_SIGINFO_COMPAT_NEEDED
-
 #define si_uid16	_sifields._kill._uid
 
 #endif /* _UAPI_BFIN_SIGINFO_H */
-- 
2.14.1
