Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51636 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbBQJov convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Feb 2015 04:44:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 33/45] include/uapi/asm-generic/signal.h: include stdlib.h in userspace
Date: Tue, 17 Feb 2015 10:44:48 +0100
Message-ID: <2372547.aJh8O9JSDy@wuerfel>
In-Reply-To: <1424127948-22484-34-git-send-email-mikko.rapeli@iki.fi>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi> <1424127948-22484-34-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150217094448.0GdS9AyvvDSwvcElReKJbc0IsXYUmnyxd9W3Hb5DL8o@z>

On Tuesday 17 February 2015 00:05:36 Mikko Rapeli wrote:
> Fixes compiler warning:
> error: unknown type name ‘size_t’
> 
> Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
> ---
>  include/uapi/asm-generic/signal.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
> index 9df61f1..8a341a2 100644
> --- a/include/uapi/asm-generic/signal.h
> +++ b/include/uapi/asm-generic/signal.h
> @@ -3,6 +3,10 @@
>  
>  #include <linux/types.h>
>  
> +#ifndef __KERNEL__
> +#include <stdlib.h>
> +#endif
> +

Hmm, maybe we should use __kernel_size_t instead?

	Arnd
