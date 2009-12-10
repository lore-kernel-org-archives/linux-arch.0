From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: What's in asm-generic.git
Date: Thu, 10 Dec 2009 22:25:05 +0100
Message-ID: <200912102225.05280.arnd@arndb.de>
References: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com> <200912102210.12124.arnd@arndb.de> <8bd0f97a0912101317v8143e67w9e2f1224111ac0d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56141 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761250AbZLJVZG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 16:25:06 -0500
In-Reply-To: <8bd0f97a0912101317v8143e67w9e2f1224111ac0d7@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 10 December 2009, Mike Frysinger wrote:
> > I have found now that sys_accept4 was missing. sys_set_thread_area however
> > is only defined on x86 and mips. Since you don't currently implement this
> > on score, maybe it would be more appropriate to handle it like the other
> > architectures do, rather than adding it to asm-generic/unistd.h?
> 
> isnt the point of asm-generic/unistd.h to collect all common syscalls
> ?  if there's syscalls that ideally should be handled by everyone but
> currently doesnt, then it's easy to define it in the header but have
> the actual entry.S leave it as a hole ...

Well, sys_thread_area is not a common syscall but rather an exception.
I haven't looked at how glibc does implents TLS on different architectures,
but I think this is commonly done purely in user space without the
need for a syscall.

	Arnd
