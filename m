Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S263063AbUKZXyE@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:26565 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263087AbUKZTm4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Nov 2004 14:42:56 -0500
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id iAPG5c1m011573
	for <linux-arch@vger.kernel.org>; Thu, 25 Nov 2004 08:05:41 -0800
Received: from d12nrmr1507.megacenter.de.ibm.com (d12nrmr1507.megacenter.de.ibm.com [9.149.167.1])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id iAPCDUbP146396
	for <linux-arch@vger.kernel.org>; Thu, 25 Nov 2004 12:13:30 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1507.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iAPCDQp3129728
	for <linux-arch@vger.kernel.org>; Thu, 25 Nov 2004 13:13:26 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id iAPCDTbd001350
	for <linux-arch@vger.kernel.org>; Thu, 25 Nov 2004 13:13:29 +0100
In-Reply-To: <200411241900.iAOJ0Wd31749@unix-os.sc.intel.com>
Subject: Re: [patch] sys_stime needs a compat function.
Message-ID: <OF86608848.CEEC08BC-ON41256F57.00430B89-41256F57.004326A3@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 25 Nov 2004 13:13:28 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: tony.luck@intel.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>





> > The original stime bug is fixed for mips, parisc, s390, sparc64 and
> > x86_64. Can the arch-maintainers please take a look at this?
>
> You missed providing a definition for __ARCH_WANT_COMPAT_SYS_TIME for
> ia64.

Ok, added the missing define

> Also I ended up with security_settime() undefined.  I think you
> need to add "#include <linux/security.h> to kernel/compat.c

and the missing #include. Thanks for testing.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
