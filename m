Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42460 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287AbXGRLBq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jul 2007 07:01:46 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0B728219A0
	for <linux-arch@vger.kernel.org>; Wed, 18 Jul 2007 13:01:45 +0200 (CEST)
From: Andi Kleen <ak@suse.de>
Subject: Fwd: [patch 075/134] i386: During VM oom condition, kill all threads in process group
Date: Wed, 18 Jul 2007 12:43:59 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v7enGreW8CqYXMb"
Message-Id: <200707181243.59783.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Boundary-00=_v7enGreW8CqYXMb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


FYI

You might want to check if your architecture needs this change too.

-Andi

--Boundary-00=_v7enGreW8CqYXMb
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: akpm@linux-foundation.org: [patch 075/134] i386: During VM oom condition, kill all threads in process group
Content-Disposition: inline

Return-Path: <akpm@linux-foundation.org>
Received: from imap.suse.de ([unix socket])
	 by imap (Cyrus v2.2.12) with LMTPA;
	 Mon, 09 Jul 2007 21:55:01 +0200
X-Sieve: CMU Sieve 2.2
Received: from Relay2.suse.de (relay2.suse.de [149.44.160.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay.suse.de", Issuer "CAcert Class 3 Root" (not verified))
	by imap.suse.de (Postfix) with ESMTP id 796A414540CF
	for <ak@imap.suse.de>; Mon,  9 Jul 2007 21:55:01 +0200 (CEST)
Received: by Relay2.suse.de (Postfix)
	id 62B042326B; Mon,  9 Jul 2007 21:55:01 +0200 (CEST)
Received: from Relay2.suse.de (localhost [127.0.0.1])
	by Relay2.suse.de (Postfix) with ESMTP id 56B5A231E6
	for <ak@suse.de>; Mon,  9 Jul 2007 21:55:01 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15])
 by Relay2.suse.de (Relay2 [149.44.160.89]) (amavisd-new, port 10025)
 with ESMTP id 23188-04 for <ak@suse.de>;
 Mon,  9 Jul 2007 21:55:00 +0200 (CEST)
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org [207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 11040215DE
	for <ak@suse.de>; Mon,  9 Jul 2007 21:54:59 +0200 (CEST)
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l69JsrKO022695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Jul 2007 12:54:58 -0700
Received: from localhost.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l69JmJXr005727;
	Mon, 9 Jul 2007 12:48:19 -0700
Message-Id: <200707091948.l69JmJXr005727@imap1.linux-foundation.org>
Subject: [patch 075/134] i386: During VM oom condition, kill all threads in process group
To: ak@suse.de
Cc: akpm@linux-foundation.org,
 will_schmidt@vnet.ibm.com
From: akpm@linux-foundation.org
Date: Mon, 09 Jul 2007 12:48:19 -0700
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Virus-Scanned: by amavisd-new at Relay2.suse.de
X-Spam-Status: No, hits=-3.6 tagged_above=-20.0 required=5.0 tests=BAYES_00,
 MY_LINUX, MY_SUSE, NO_REAL_NAME, SPF_PASS
X-Spam-Level: 
X-Length: 3568
X-UID: 109287

From: Will Schmidt <will_schmidt@vnet.ibm.com>

During a VM oom condition, kill all threads in the process group.

We have had complaints where a threaded application is left in a bad state
after one of it's threads is killed when we hit a VM: out_of_memory condition.

Killing just one of the process threads can leave the application in a bad
state, whereas killing the entire process group would allow for the
application to restart, or otherwise handled, and makes it very obvious that
something has gone wrong.

This change allows the entire process group to be taken down, rather than just
the one thread.

tested lightly on i386.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/i386/mm/fault.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/mm/fault.c~i386-during-vm-oom-condition arch/i386/mm/fault.c
--- a/arch/i386/mm/fault.c~i386-during-vm-oom-condition
+++ a/arch/i386/mm/fault.c
@@ -598,7 +598,7 @@ out_of_memory:
 	}
 	printk("VM: killing process %s\n", tsk->comm);
 	if (error_code & 4)
-		do_exit(SIGKILL);
+		do_group_exit(SIGKILL);
 	goto no_context;
 
 do_sigbus:
_

--Boundary-00=_v7enGreW8CqYXMb--
