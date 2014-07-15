Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58763 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758043AbaGOKYu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 06:24:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 24/29] nios2: Module support
Date: Tue, 15 Jul 2014 12:24:46 +0200
Message-ID: <6364841.e2Acy30lOs@wuerfel>
In-Reply-To: <1405413956-2772-25-git-send-email-lftan@altera.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-25-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140715102446.m9HVHuwX9UdGSRttumyJD6n_NBQMm38mCp6e10B3gQc@z>

On Tuesday 15 July 2014 16:45:51 Ley Foon Tan wrote:
> +void *module_alloc(unsigned long size)
> +{
> +	if (size == 0)
> +		return NULL;
> +	return kmalloc(size, GFP_KERNEL);
> +}
> +
> +/* Free memory returned from module_alloc */
> +void module_free(struct module *mod, void *module_region)
> +{
> +	kfree(module_region);
> +}

Any particular reason for defining these to use kmalloc rather than
the default vmalloc based functions?

Note that kmalloc is more limited in size and won't work if the memory
is fragmented, while vmalloc has a small overhead on some architectures
due to TLB pressure, but only if the normal kernel memory is able to
use huge pages.

> +void module_arch_cleanup(struct module *mod)
> +{
> +}

This is not needed at all.

	Arnd
