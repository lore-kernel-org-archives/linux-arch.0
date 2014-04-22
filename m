Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49245 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756571AbaDVObF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 10:31:05 -0400
Date: Tue, 22 Apr 2014 11:30:37 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 08/28] nios2: MMU Fault handling
Message-ID: <20140422143036.GD15745@arch.cereza>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397824031-4892-6-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1397824031-4892-6-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140422143037.405urmdBTzyws-enWalq_6lDLTJc--kESVwdC-bvmvY@z>

Hello Ley Foon,

On Apr 18, Ley Foon Tan wrote:
> +
> +bad_area_nosemaphore:
> +	/* User mode accesses just cause a SIGSEGV */
> +	if (user_mode(regs)) {

I found that it's useful to add some printing here, just as ARM
does. I carry this patch on my kernel:

+               printk(KERN_INFO "%s: unhandled page fault (%d) at 0x%08lx, cause %ld\n",
+                      current->comm, SIGSEGV, address, cause);
+               show_regs(regs);

Do you think we could do something like it? Maybe with a compile time option?

> +		_exception(SIGSEGV, regs, code, address);
> +		return;
> +	}
> +
-- 
Ezequiel García, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
