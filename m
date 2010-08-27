Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22690 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133Ab0H0B7O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Aug 2010 21:59:14 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/22] Alpha: Fix a missing comma in sys_osf_statfs()
Date: Fri, 27 Aug 2010 02:59:10 +0100
Message-ID: <20100827015910.27277.7657.stgit@warthog.procyon.org.uk>
In-Reply-To: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
References: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <20100827015910.sauAE6TFTuNfa3EvcNEQrVGOcs3DnW-x6LMmz-2qbw4@z>

Fix a comma that got accidentally deleted from sys_osf_statfs() leading to the
following warning:

	arch/alpha/kernel/osf_sys.c: In function 'SYSC_osf_statfs':
	arch/alpha/kernel/osf_sys.c:255: error: syntax error before 'buffer'

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/alpha/kernel/osf_sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index fb58150..5d1e6d6 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -252,7 +252,7 @@ SYSCALL_DEFINE3(osf_statfs, const char __user *, pathname,
 
 	retval = user_path(pathname, &path);
 	if (!retval) {
-		retval = do_osf_statfs(&path buffer, bufsiz);
+		retval = do_osf_statfs(&path, buffer, bufsiz);
 		path_put(&path);
 	}
 	return retval;

