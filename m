From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/24] C6X: module support
Date: Tue, 9 Aug 2011 18:56:33 +0200
Message-ID: <201108091856.33829.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-17-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62694 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1HIQ4i (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:56:38 -0400
In-Reply-To: <1312839879-13592-17-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:

> +extern unsigned long long __c6xabi_divull(unsigned long long n,
> +					  unsigned long long d);
> +EXPORT_SYMBOL(__c6xabi_divull);

A full 64 bit division is very expensive. We have the div64() macro
in the kernel to avoid that. It would be a useful optimization to
provide a working div64 and remove the __c6xabi_divull export.

> +void *module_alloc(unsigned long size)
> +{
> +	if (size == 0)
> +		return NULL;
> +	return vmalloc_exec(size);
> +}
> +
> +
> +/* Free memory returned from module_alloc */
> +void module_free(struct module *mod, void *module_region)
> +{
> +	vfree(module_region);
> +}
> +
> +/*
> + * finish loading the module
> + */
> +int module_finalize(const Elf_Ehdr *hdr,
> +		    const Elf_Shdr *sechdrs,
> +		    struct module *me)
> +{
> +	return 0;
> +}
> +
> +/*
> + * finish clearing the module
> + */
> +void module_arch_cleanup(struct module *mod)
> +{
> +	module_bug_cleanup(mod);
> +}
> +
> +
> +/* We don't need anything special. */
> +int module_frob_arch_sections(Elf_Ehdr *hdr,
> +			      Elf_Shdr *sechdrs,
> +			      char *secstrings,
> +			      struct module *mod)
> +{
> +	return 0;
> +}

After openrisc was merged, you no longer need to provide these functions,
they are the default anyway.

	Arnd
