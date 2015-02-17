Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63280 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933397AbbBQJQM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Feb 2015 04:16:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 34/45] include/uapi/asm-generic/signal.h: hide sigset_t definition in userspace
Date: Tue, 17 Feb 2015 10:16:09 +0100
Message-ID: <2741317.tcRFXAy9C6@wuerfel>
In-Reply-To: <1424127948-22484-35-git-send-email-mikko.rapeli@iki.fi>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi> <1424127948-22484-35-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150217091609.XWtx6VLZa0Lfjx4QktPetCImXtExG6rgMKL8en4c3pY@z>

On Tuesday 17 February 2015 00:05:37 Mikko Rapeli wrote:
> +#ifdef __KERNEL__
> +/* already defined in userspace via stdlib.h */
>  typedef struct {
>         unsigned long sig[_NSIG_WORDS];
>  } sigset_t;
> +#endif /* __KERNEL__ */

I'm not sure here: Is this structure always identical to the one
we see in user space?

If not, we might want to rename the typedef to __kernel_sigset_t
instead and use that inside of the uapi headers.

	Arnd
