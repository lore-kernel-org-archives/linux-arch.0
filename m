Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:64190 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182AbaDVMa4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 08:30:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/28] nios2: System calls handling
Date: Tue, 22 Apr 2014 14:30:39 +0200
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <1397824031-4892-13-git-send-email-lftan@altera.com>
In-Reply-To: <1397824031-4892-13-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201404221430.40237.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140422123039.j201mJZbzKnZirlEjJmduHE83ugssDHVfM59aeDASQo@z>

On Friday 18 April 2014, Ley Foon Tan wrote:

> +
> + #define sys_mmap2 sys_mmap_pgoff
> +

You use sys_mmap_pgoff here, but

> +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> +			unsigned long prot, unsigned long flags,
> +			unsigned long fd, unsigned long offset)
> +{
> +	if (offset & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	return sys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
> +}

define a separate sys_mmap() here. Doing the former should be enough.
so you can just drop the sys_mmap definition.

	Arnd
