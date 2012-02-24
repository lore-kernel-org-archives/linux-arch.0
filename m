From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] [PATCH] asm-generic/unistd.h: handle symbol prefixes in cond_syscall
Date: Fri, 24 Feb 2012 16:37:30 +0000
Message-ID: <201202241637.30284.arnd@arndb.de>
References: <4F47981F.4020305@imgtec.com> <201202241424.07319.arnd@arndb.de> <201202241119.44480.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55819 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab2BXQhe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 11:37:34 -0500
In-Reply-To: <201202241119.44480.vapier@gentoo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Friday 24 February 2012, Mike Frysinger wrote:
> > Our trend is to move away from arch specific Kconfig symbols and
> > __ARCH_HAS_* macros towards just defining whatever you need in the
> > architecture as an override for the generic definition.
> 
> i don't see how __ARCH_HAS_xxx would help here.  the symbol prefix is a string, 
> not a bool value.  it's also already used by linux/export.h, asm-
> generic/vmlinux.lds.h, and module code in scripts/.

I gave __ARCH_HAS_xxx as an example because a lot of other places use that
to abstract architecture specific features, even if that wouldn't apply
here.

> > Just provide your own unistd.h that does
> 
> the point of asm-generic is so that arches don't have to keep copying & 
> pasting things that they really don't care about.  James' proposed patch looks 
> good to me.  it might be nice to go even further and add logic to a core 
> header so that CONFIG_SYMBOL_PREFIX is always defined ...

You are right. I did not realize that CONFIG_SYMBOL_PREFIX is an existing
symbol rather one that James defined for this purpose.

We actually have MODULE_SYMBOL_PREFIX providing the correct string
under a name that is not appropriate here. We can probably stick with
Jason's patch for now and add a more sophisticated logic if another
user of CONFIG_SYMBOL_PREFIX comes up.

So for Jason's patch:

Acked-by: Arnd Bergmann <arnd@arndb.de>

We could put that into the kernel now, but it's probably sufficient if
Jason keeps the patch with his others and submits it at the same time
when we get there.

	Arnd
