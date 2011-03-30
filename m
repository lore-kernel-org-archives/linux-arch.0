From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] unicore32 fix: remove arch-specific futex support
Date: Wed, 30 Mar 2011 14:40:03 +0200
Message-ID: <201103301440.03479.arnd@arndb.de>
References: <01eb01cbeeb7$30390460$90ab0d20$@mprc.pku.edu.cn> <201103301417.20027.arnd@arndb.de> <alpine.LFD.2.00.1103301421390.22418@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52938 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab1C3Mpw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2011 08:45:52 -0400
In-Reply-To: <alpine.LFD.2.00.1103301421390.22418@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 30 March 2011, Thomas Gleixner wrote:
> The problem is that you need cmpxchg in user space as well.
> 
> ARM does this with some syscall magic for machines which do not have
> cmpxchg.

Ah, right. I wonder how sh does it.

I also remember that the original unicore32 ABI had support for a cmpxchg
system call, but that was removed with the move to the generic syscall
table.

It is of course possible to add it back using the __NR_arch_specific_syscall
entry point.

	Arnd
