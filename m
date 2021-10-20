Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A58C433EF
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF0B613A3
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJTRrL (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:47:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40460 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhJTRrH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55052)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe0-00GCwM-DG; Wed, 20 Oct 2021 11:44:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdz-001NdN-4w; Wed, 20 Oct 2021 11:44:51 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Maciej Rozycki <macro@orcam.me.uk>, linux-mips@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:43:51 -0500
Message-Id: <20211020174406.17889-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFdz-001NdN-4w;;;mid=<20211020174406.17889-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vAFcVjANIu4vDNha2bth++KrviZjJJPY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 05/20] signal/mips: Update (_save|_restore)_fp_context to fail with -EFAULT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When an instruction to save or restore a register from the stack fails
in _save_fp_context or _restore_fp_context return with -EFAULT.  This
change was made to r2300_fpu.S[1] but it looks like it got lost with
the introduction of EX2[2].  This is also what the other implementation
of _save_fp_context and _restore_fp_context in r4k_fpu.S does, and
what is needed for the callers to be able to handle the error.

Furthermore calling do_exit(SIGSEGV) from bad_stack is wrong because
it does not terminate the entire process it just terminates a single
thread.

As the changed code was the only caller of arch/mips/kernel/syscall.c:bad_stack
remove the problematic and now unused helper function.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Maciej Rozycki <macro@orcam.me.uk>
Cc: linux-mips@vger.kernel.org
[1] 35938a00ba86 ("MIPS: Fix ISA I FP sigcontext access violation handling")
[2] f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
Fixes: f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mips/kernel/r2300_fpu.S | 4 ++--
 arch/mips/kernel/syscall.c   | 9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
index 12e58053544f..cbf6db98cfb3 100644
--- a/arch/mips/kernel/r2300_fpu.S
+++ b/arch/mips/kernel/r2300_fpu.S
@@ -29,8 +29,8 @@
 #define EX2(a,b)						\
 9:	a,##b;							\
 	.section __ex_table,"a";				\
-	PTR	9b,bad_stack;					\
-	PTR	9b+4,bad_stack;					\
+	PTR	9b,fault;					\
+	PTR	9b+4,fault;					\
 	.previous
 
 	.set	mips1
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 2afa3eef486a..5512cd586e6e 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -240,12 +240,3 @@ SYSCALL_DEFINE3(cachectl, char *, addr, int, nbytes, int, op)
 {
 	return -ENOSYS;
 }
-
-/*
- * If we ever come here the user sp is bad.  Zap the process right away.
- * Due to the bad stack signaling wouldn't work.
- */
-asmlinkage void bad_stack(void)
-{
-	do_exit(SIGSEGV);
-}
-- 
2.20.1

