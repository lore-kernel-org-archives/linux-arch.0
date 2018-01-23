From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 01/10] ptrace: Use copy_siginfo in setsiginfo and getsiginfo
Date: Tue, 23 Jan 2018 15:07:10 -0600
Message-ID: <20180123210719.10456-1-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:51868 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeAWVIz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 16:08:55 -0500
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Now that copy_siginfo copies all of the fields this is safe, safer (as
all of the bits are guaranteed to be copied), clearer, and less error
prone than using a structure copy.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index ec4365da9be8..f3c82e26b995 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -659,7 +659,7 @@ static int ptrace_getsiginfo(struct task_struct *child, siginfo_t *info)
 	if (lock_task_sighand(child, &flags)) {
 		error = -EINVAL;
 		if (likely(child->last_siginfo != NULL)) {
-			*info = *child->last_siginfo;
+			copy_siginfo(info, child->last_siginfo);
 			error = 0;
 		}
 		unlock_task_sighand(child, &flags);
@@ -675,7 +675,7 @@ static int ptrace_setsiginfo(struct task_struct *child, const siginfo_t *info)
 	if (lock_task_sighand(child, &flags)) {
 		error = -EINVAL;
 		if (likely(child->last_siginfo != NULL)) {
-			*child->last_siginfo = *info;
+			copy_siginfo(child->last_siginfo, info);
 			error = 0;
 		}
 		unlock_task_sighand(child, &flags);
-- 
2.14.1
