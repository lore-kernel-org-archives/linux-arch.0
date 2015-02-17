From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 45/45] include/uapi/asm-generic/ucontext.h: include signal.h and sigcontext.h
Date: Tue, 17 Feb 2015 10:10:42 +0100
Message-ID: <3121580.utRRJPcIC6@wuerfel>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi> <1424127948-22484-46-git-send-email-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60701 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258AbbBQJKw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Feb 2015 04:10:52 -0500
In-Reply-To: <1424127948-22484-46-git-send-email-mikko.rapeli@iki.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

On Tuesday 17 February 2015 00:05:48 Mikko Rapeli wrote:
>  #ifndef __ASM_GENERIC_UCONTEXT_H
>  #define __ASM_GENERIC_UCONTEXT_H
>  
> +#include <asm-generic/signal.h>
> +#include <asm/sigcontext.h>
> +
>  struct ucontext {
> 

Including another asm-generic header here is a bad idea: it breaks
if an architecture overrides asm/signal.h with its own version
but wants to use the asm-generic/ucontext.h file.

It would be best to just use linux/signal.h here, which includes
the correct architecture specific files.

	Arnd
