Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:21196 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751351AbWIDT4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2006 15:56:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around _syscall*()
Date: Mon, 4 Sep 2006 21:56:39 +0200
References: <200608302359.k7UNxIZW027536@hera.kernel.org> <1157398050.2473.137.camel@shinybook.infradead.org> <20060904123801.905fabc6.akpm@osdl.org>
In-Reply-To: <20060904123801.905fabc6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609042156.40143.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Am Monday 04 September 2006 21:38 schrieb Andrew Morton:
> I think we're working on removing the _syscall() things altogether.  The
> main problem is execve() and I have a series from Arnd queued up to fix
> execve.
>
> I think that there are some remaining uses after execve, but I'm not sure
> what they are.  Arnd, do you recall?

My patch series removed all users in the kernel.

The reason I backed out from removing _syscallX() along with it was
that it is still controversial whether it has any value to user space.

Andi's point was that it is an essential part of the kernel ABI and
we should not break existing source using these macros, especially
since the alternative syscall() function provided by glibc has been
frequently broken in the past on x86.

HPA made the point that syscall() from glibc is by design inefficient
on some architectures, so there may be reasons to use _syscallX() instead.

There are lots of arguments in favor of removing them.

	Arnd <><
