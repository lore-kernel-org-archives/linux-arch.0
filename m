From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 14:23:27 +0100
Message-ID: <200812111423.27523.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <cover.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57936 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487AbYLKNX2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 08:23:28 -0500
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org

On Thursday 11 December 2008, Kyle McMartin wrote:
> Create a common kernel/init_task.c, and convert low hanging fruit to
> use it. Architecture maintainers will need to ensure that I didn't
> break anything before applying the init_task removal patch to their
> arch.

Incidentally, I was working on the same stuff already, just didn't
get around to posting it before the discussion arose here.
My patches were largely identical, so I'm just commenting on
what I found beyond what you did.

The major difference to my patch is that I added a CONFIG_GENERIC_INIT_TASK
to each architecture I converted rather than remove the HAVE_ARCH_INIT_TASK.

> A few architectures appear to possibly rely on link-ordering (with
> an extra-y makefile rule) and may need additional linker script rules.

My approach was add "head-y += kernel/init_task" to each architecture
Makefile in order to keep the link order the same. If it work without
that, even better.

> Unconverted architectures so far are m68k (because it doesn't use an explicit
> init_task.c), ia64 (because it faffs about with init_thread_union), and
> sparc{,64} (which appear to rely on some magic.)

And you forgot about um and cris. I'll follow up with trivial patches.

> The other open question is what to do about init_mm, which was supposed to be
> removed in 2.6.26...

Only the EXPORT_SYMBOL was to be removed, not the init_mm itself, because
it is still referenced by init_task. I'd vote for not putting the export
into kernel/init_task.c. There are no modular users in the kernel.

	Arnd <><
