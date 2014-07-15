From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 24/29] nios2: Module support
Date: Tue, 15 Jul 2014 12:24:46 +0200
Message-ID: <6364841.e2Acy30lOs@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-25-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1405413956-2772-25-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

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
