From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 27/31] arm64: Loadable modules
Date: Wed, 15 Aug 2012 15:23:21 +0000
Message-ID: <201208151523.21447.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-28-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58924 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab2HOPXY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 11:23:24 -0400
In-Reply-To: <1344966752-16102-28-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> +
> +void *module_alloc(unsigned long size)
> +{
> +       return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> +                                   GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
> +                                   __builtin_return_address(0));
> +}
> +

What is the reason for using a separate virtual address range for the
modules instead of falling back to the default module_alloc function
that uses vmalloc_exec()?

	Arnd
