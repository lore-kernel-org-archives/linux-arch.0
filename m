Return-Path: <arnd@arndb.de>
Received: from natnoddy.rzone.de ([81.169.145.166]:16811 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262910AbUDDXBI
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 4 Apr 2004 19:01:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Date: Mon, 5 Apr 2004 00:51:29 +0200
References: <200404040204.03594.arnd@arndb.de> <20040404122404.54329a2e.ak@suse.de> <20040404110756.GB791@holomorphy.com>
In-Reply-To: <20040404110756.GB791@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404050051.29932.arnd@arndb.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sunday 04 April 2004 13:07, William Lee Irwin III wrote:
> I can second that one; I've seen stuff that "passes LTP" but blatantly
> flunks rather simplistic off-the-cuff a priori sanity checks. One
> example that stands out is a recent patch ppl were rather foolishly
> trying to get my endorsement on that pandered to (ir)Rational crap code.

I just found another example when I tried to open a ppp connection
with my patches :(

This needs to be applied on top of the sys32_select consolidation
patch to get the correct return value from select when called with
nonzero timeout.

===== fs/compat.c 1.25 vs edited =====
--- 1.25/fs/compat.c	Sat Apr  3 23:51:59 2004
+++ edited/fs/compat.c	Mon Apr  5 00:48:52 2004
@@ -1377,8 +1377,9 @@
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
-		ret = __put_user(sec, &tvp->tv_sec);
-		ret |= __put_user(usec, &tvp->tv_usec);
+		if (put_user(sec, &tvp->tv_sec) ||
+		    put_user(usec, &tvp->tv_usec))
+			ret = -EFAULT;
 	}
 
 	if (ret < 0)
