From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH] Remove flush_icache_user_range()
Date: Wed, 09 Apr 2014 12:09:26 -0400 (EDT)
Message-ID: <20140409.120926.1586922018370125781.davem@davemloft.net>
References: <20140409100150.GO16119@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56094 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbaDIQJc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Apr 2014 12:09:32 -0400
In-Reply-To: <20140409100150.GO16119@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@arm.linux.org.uk
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, gerg@uclinux.org, geert@linux-m68k.org, monstr@monstr.eu, yasutake.koichi@jp.panasonic.com, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, arnd@arndb.de

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 9 Apr 2014 11:01:50 +0100

> What has been proposed for uprobes is a uprobe specific function -
> flush_uprobe_xol_access() which is used after uprobes writes via the
> kmap_atomic() mapping of the page:
> 
> +       xol_page_kaddr = kmap_atomic(area->page);
> +
> +       /* Initialize the slot */
> +       memcpy(xol_page_kaddr + (xol_vaddr & ~PAGE_MASK),
> +              &uprobe->arch.ixol,
> +              sizeof(uprobe->arch.ixol));
> +
> +       arch_uprobe_flush_xol_access(area->page, xol_vaddr,
> +                                    xol_page_kaddr + (xol_vaddr & ~PAGE_MASK),
> +                                    sizeof(uprobe->arch.ixol));
> +
> +       kunmap_atomic(xol_page_kaddr);
> 
> Comments?

ptrace() accesses (via __access_remote_vm()) already use an existing
helper function for these sorts of situations, in the form of
copy_{to,from}_user_page().  I would suggest that uprobes uses that
as well.
