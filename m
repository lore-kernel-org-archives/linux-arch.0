Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:11686 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S264213AbUDHIdG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2004 04:33:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Date: Thu, 8 Apr 2004 10:22:38 +0200
References: <200404040204.03594.arnd@arndb.de> <200404040222.41413.arnd@arndb.de> <407468A8.5060309@intel.com>
In-Reply-To: <407468A8.5060309@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404081022.38720.arnd@arndb.de>
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 07 April 2004 22:46, you wrote:
> While your patches improved compatibility with respect to LSB/LTP,
> we saw the following regressions on LTP on ia64: 
> 
> recv01      PASS->BROK
> recvmsg01    PASS->BROK
> recvfrom01    PASS->BROK
> 
> While we're looking into it, did others see this ? 
> Is it fixed already ? 

Did you apply the patch I sent in the followup mail? It looks
like you ran into the problem. Here it is again in case you
missed it.

	Arnd <><

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
