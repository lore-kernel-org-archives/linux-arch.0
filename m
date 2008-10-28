From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: On spreading atomic_t initialization
Date: Tue, 28 Oct 2008 18:29:43 +0300
Message-ID: <20081028152943.GA20989@x200.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45286 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbYJ1P0U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Oct 2008 11:26:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so987799nfc.21
        for <linux-arch@vger.kernel.org>; Tue, 28 Oct 2008 08:26:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

I wrote stupid runtime checker to look for atomic_t uninitialized usage
and the amount of screaming in logs is surprisingly very big.

So the question: is there really really an arch for which setting atomic_t
by hand (kzalloc) is not equivalent to atomic_set()?

Given the following patch, there is none almost certainly.

--- a/kernel/user.c
+++ b/kernel/user.c
@@ -405,6 +405,9 @@ struct user_struct *alloc_uid(struct user_namespace *ns, uid_t uid)
 
 		new->uid = uid;
 		atomic_set(&new->__count, 1);
+		atomic_set(&new->processes, 0);
+		atomic_set(&new->files, 0);
+		atomic_set(&new->sigpending, 0);
 
 		if (sched_create_user(new) < 0)
 			goto out_free_user;


Such checker will still be useful to catch genuine uninitialized usages,
but the amount of stuff to shut up before it can realistically be put in -mm
is amazing.
