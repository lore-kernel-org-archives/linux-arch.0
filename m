Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfABU3l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Jan 2019 15:29:41 -0500
Date: Wed, 2 Jan 2019 21:29:39 +0100
From: Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
Message-ID: <20190102202938.GA26600@linux-8ccs>
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathias Krause <minipli@googlemail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Message-ID: <20190102202939.0eiJqLnqMHsvVHqOZrzb0kgZHy6hdp5afTjI-wjULf4@z>

+++ Mathias Krause [30/12/18 13:40 +0100]:
>The reference to '__vermagic' is a relict from v2.5 times. And even
>there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
>("Module Sanity Check") in the historic tree) to v2.5.69 (commit
>67ac5b866bda ("[PATCH] complete modinfo section")).
>
>Neither current kernels nor modules contain a '__vermagic' section any
>more, so get rid of it.
>
>Signed-off-by: Mathias Krause <minipli@googlemail.com>
>Cc: Rusty Russell <rusty@rustcorp.com.au>
>Cc: Jessica Yu <jeyu@kernel.org>

Thanks for the cleanup.

Reviewed-by: Jessica Yu <jeyu@kernel.org>

>---
> include/asm-generic/vmlinux.lds.h | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index 3d7a6a9c2370..530ce1e7a1ec 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -332,7 +332,6 @@
> 		__start_rodata = .;					\
> 		*(.rodata) *(.rodata.*)					\
> 		RO_AFTER_INIT_DATA	/* Read only after init */	\
>-		KEEP(*(__vermagic))	/* Kernel version magic */	\
> 		. = ALIGN(8);						\
> 		__start___tracepoints_ptrs = .;				\
> 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>-- 
>2.19.2
>
