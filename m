Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:60478 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYDWPA1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2008 11:00:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Wed, 23 Apr 2008 16:59:24 +0200
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422153849.GH19802@phobos.i.cabal.ca> <87a5b0800804230736k340e7fe9mffbd72b5b8164015@mail.gmail.com>
In-Reply-To: <87a5b0800804230736k340e7fe9mffbd72b5b8164015@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200804231659.24463.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton@gmail.com>
Cc: Kyle McMartin <kyle@mcmartin.ca>, Randy Dunlap <randy.dunlap@oracle.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20080423145924.SqNTWaEt9RwbswHHh5gu8TnS2r0ifMNkYx1l0ZXuHqw@z>

On Wednesday 23 April 2008, Will Newton wrote:
> I implemented the approach you suggested - Kconfig symbol and
> cond_syscall definition. I think I actually like the previous approach
> better:
> 
> 1. The arch Kconfig files are quite non-uniform compared to unistd.h
> so the definitions wind up at different places in the file which is a
> bit messy.
> 2. Changes to Kconfig may cause churn in defconfigs perhaps?
> 3. There is more churn in arch Kconfig than unistd.h so getting a
> cross arch patch applied is likely to be more difficult.
> 4. The patch is about 4 times as many lines.
> 
> What do you think?

I still feel that the original patch was more helpful and consistent
with how we do it for the existing obsolete syscalls.

Note that there is a much simpler solution if you just use an
"#ifdef __NR_sys_sysfs" around the definition of the syscall, but
that has another disadvantage in that it is harder to spot when
new architectures get it wrong.

	Arnd <><
