Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx.pathscale.com ([198.186.3.68]:43666 "EHLO mx.pathscale.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbXGSWmS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2007 18:42:18 -0400
Date: Thu, 19 Jul 2007 15:24:11 -0700
From: Arthur Jones <arthur.jones@qlogic.com>
Subject: build fix for x86_64...
Message-ID: <20070719222411.GO12489@bauxite.pathscale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: Vasily Tarasov <vtaras@openvz.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>, Jan Kara <jack@ucw.cz>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi vasily,

commit b716395e2b8e450e294537de0c91476ded2f0395
breaks the build for x86_64 (and ia64 too, i guess) if
CONFIG_COMPAT is not turned on.  here is a patch, which
i think is more complete than the previous one posted
to LKML by Doug Chapman (which only fixes ia64, i think).
it lets the build continue, but i have no idea if it's
correct or not..

arthur

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="t.patch"

diff --git a/fs/quota.c b/fs/quota.c
index e6577ac..5baeede 100644
--- a/fs/quota.c
+++ b/fs/quota.c
@@ -387,7 +387,7 @@ asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special, qid_t
 	return ret;
 }
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_IA64)
+#if defined(CONFIG_COMPAT) && (defined(CONFIG_X86_64) || defined(CONFIG_IA64))
 /*
  * This code works only for 32 bit quota tools over 64 bit OS (x86_64, ia64)
  * and is necessary due to alignment problems.

--6sX45UoQRIJXqkqR--
