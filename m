From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 37/55] ARC: dynamic loadable module support
Date: Mon, 12 Nov 2012 13:53:15 +0000
Message-ID: <201211121353.15314.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-7-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50584 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab2KLNxZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 08:53:25 -0500
In-Reply-To: <1352720953-24321-7-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet.Gupta1@synopsys.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
> +void *module_alloc(unsigned long size)
> +{
> +       if (size == 0)
> +               return NULL;
> +
> +       return vmalloc(size);
> +
> +}
> +
> +void module_free(struct module *module, void *region)
> +{
> +       vfree(region);
> +}
> +
> +int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> +                             char *secstr, struct module *mod)
> +{
> +    return 0;
> +}
> +
> +void module_arch_cleanup(struct module *mod)
> +{
> +}
> +
> +int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
> +                   struct module *mod)
> +{
> +    return 0;
> +} 

All of these are identical to the default implementation in kernel/module.c
and you can simply drop your own definitions.

	Arnd
