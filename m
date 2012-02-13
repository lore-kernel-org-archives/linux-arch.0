Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55593 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab2BMDAF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2012 22:00:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend] asm/types.h: All architectures use int-ll64.h in kernelspace
Date: Mon, 13 Feb 2012 02:59:32 +0000
References: <alpine.DEB.2.00.1108132152050.18053@ayla.of.borg> <1665974.2LGtkbyJmJ@wuerfel> <20120211094444.GL23916@ZenIV.linux.org.uk>
In-Reply-To: <20120211094444.GL23916@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201202130259.33347.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>
Message-ID: <20120213025932.CDp3D0fznZQMV6brId-CYEyGqnzLi1TZgu51R16Szt4@z>

On Saturday 11 February 2012, Al Viro wrote:

> Umm...  That has happened and yes, asm-generic/types.h is currently
> equivalent to asm-generic/int-ll64.h.  What exactly are you planning
> to do?  Just rename the latter to the former and do search-and-replace
> over the tree?  We still have places that pull int-l64.h, albeit only
> !__KERNEL__ ones (i.e. everything under #ifdef __KERNEL__ in there
> seems to be killable)...
> 
> AFAICS, for quite a few of those guys we can simply add bitsperlong.h
> and add types.h to generic-y; is that the plan?

Yes, I think both would be good cleanups. Maybe David Howells can comment
as well since his user api split is going to change that a bit:
We end up needing only a separate version of uapi/asm/types.h for
alpha/ia64/mips64/powerpc64, while the in-kernel file is ok.

	Arnd
