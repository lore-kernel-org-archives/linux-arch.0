Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30026C433EF
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1316F611F2
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhJTRq5 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:46:57 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40414 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTRq5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:46:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:54948)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdp-00GCv6-SX; Wed, 20 Oct 2021 11:44:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdo-001NdN-VK; Wed, 20 Oct 2021 11:44:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 Oct 2021 12:43:47 -0500
Message-Id: <20211020174406.17889-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFdo-001NdN-VK;;;mid=<20211020174406.17889-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/vH9BzxZMJil3hyUi3PHXKmsFqUHXgmG4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 01/20] exit/doublefault: Remove apparently bogus comment about rewind_stack_do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I do not see panic calling rewind_stack_do_exit anywhere, nor can I
find anywhere in the history where doublefault_shim has called
rewind_stack_do_exit.  So I don't think this comment was ever actually
correct.

Cc: Andy Lutomirski <luto@kernel.org>
Fixes: 7d8d8cfdee9a ("x86/doublefault/32: Rewrite the x86_32 #DF handler and unify with 64-bit")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/doublefault_32.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index d1d49e3d536b..3b58d8703094 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -77,9 +77,6 @@ asmlinkage noinstr void __noreturn doublefault_shim(void)
 	 * some way to reconstruct CR3.  We could make a credible guess based
 	 * on cpu_tlbstate, but that would be racy and would not account for
 	 * PTI.
-	 *
-	 * Instead, don't bother.  We can return through
-	 * rewind_stack_do_exit() instead.
 	 */
 	panic("cannot return from double fault\n");
 }
-- 
2.20.1

