Return-Path: <arun.sharma@intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:4997 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261262AbUCPTMI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Mar 2004 14:12:08 -0500
Message-ID: <40575155.3070208@intel.com>
Date: Tue, 16 Mar 2004 11:11:17 -0800
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: [patch 1/1] generic 32 bit emulation for System-V IPC
References: <200403152253.i2FMrSE09813@mail.osdl.org>
In-Reply-To: <200403152253.i2FMrSE09813@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: torvalds@osdl.org, arnd@arndb.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

akpm@osdl.org wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Adds a generic implementation of 32 bit emulation for IPC system
> calls. The code is based on the existing implementations for sparc64,
> ia64, mips, s390, ppc and x86_64, which can subsequently be converted
> to use this.

Could we get rid of CONFIG_SYSVIPC_COMPAT and use something like:

--- linux-2.6-cvs/ipc/Makefile- 2004-03-16 10:53:48.000000000 -0800
+++ linux-2.6-cvs/ipc/Makefile  2004-03-16 10:53:49.000000000 -0800
@@ -4,5 +4,8 @@

  obj-y   := util.o

-obj-$(CONFIG_SYSVIPC_COMPAT) += compat.o
+ifeq ($(CONFIG_SYSVIPC),y)
+obj-$(CONFIG_COMPAT) += compat.o
+endif
+
  obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o

	-Arun
