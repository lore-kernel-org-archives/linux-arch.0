From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 10/19] OpenRISC: System calls
Date: Tue, 5 Jul 2011 17:39:34 +0200
Message-ID: <201107051739.34242.arnd@arndb.de>
References: <1309641352-18714-1-git-send-email-jonas@southpole.se> <1309641352-18714-11-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60892 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab1GEPjg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2011 11:39:36 -0400
In-Reply-To: <1309641352-18714-11-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Saturday 02 July 2011, Jonas Bonn wrote:
> +
> +asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
> +                         unsigned long prot, unsigned long flags,
> +                         unsigned long fd, unsigned long pgoff)
> +{
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
> +}
> +
> +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> +                        unsigned long prot, unsigned long flags,
> +                        unsigned long fd, off_t pgoff)
> +{
> +       if (pgoff & ~PAGE_MASK)
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd, pgoff >> PAGE_SHIFT);
> +}

You shouldn't really need these two. Either provide just sys_mmap2,
or "#define sys_mmap2 sys_mmap_pgoff" and change your user implementation.

	Arnd
