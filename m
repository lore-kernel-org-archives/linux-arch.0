Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63078 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbbCKKC3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 06:02:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 33/45] include/uapi/asm-generic/signal.h: include stdlib.h in userspace
Date: Wed, 11 Mar 2015 11:02:13 +0100
Message-ID: <2194220.H3M4AuVBTf@wuerfel>
In-Reply-To: <20150310225828.GZ12550@lakka.kapsi.fi>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi> <2372547.aJh8O9JSDy@wuerfel> <20150310225828.GZ12550@lakka.kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Geoff Levand <geoff@infradead.org>, Paul Bolle <pebolle@tiscali.nl>
Message-ID: <20150311100213.k2eLWpAqavBjxspOXLu-fyuqQDNO9a4av1xq77i06tg@z>

On Wednesday 11 March 2015 00:58:28 Mikko Rapeli wrote:
> linux/kexec.h seems suspicious though:
> 
> #ifndef __KERNEL__
> /*
>  * This structure is used to hold the arguments that are used when
>  * loading  kernel binaries.
>  */
> struct kexec_segment {
>         const void *buf;
>         size_t bufsz;
>         const void *mem;
>         size_t memsz;
> };
> 
> #endif /* __KERNEL__ */
> 

Hmm, maybe that just needs to be removed as well, after we
have removed the function declaration that used to follow it
as part of this commit:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9dc5c05f45ca8101025046cd

Using __kernel_size_t would work here as well, but I suspect that
the entire structure is useless as it is not used by kernel or
user space, and kexec_tools has its own copy of the structure.

	Arnd
