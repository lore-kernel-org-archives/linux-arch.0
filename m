Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:37962 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeAPAlc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:41:32 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 15 Jan 2018 18:39:49 -0600
Message-ID: <20180116004009.31036-2-ebiederm@xmission.com>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Subject: [PATCH 02/22] signal: Document the strange si_codes used by ptrace event stops
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180116003949.n37PCmnqqoyVJsJpwVYiQ2ZA0QIP-DD5AF0G-XybYRM@z>

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/uapi/asm-generic/siginfo.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cbe1b0cc7a6a..7158421ac911 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -225,6 +225,11 @@ typedef struct siginfo {
 #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
 #define NSIGTRAP	4
 
+/*
+ * There are an additional set of SIGTRAP si_codes used by ptrace
+ * that of the form: ((PTRACE_EVENT_XXX << 8) | SIGTRAP)
+ */
+
 /*
  * SIGCHLD si_codes
  */
-- 
2.14.1
