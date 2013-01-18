From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 48/76] ARC: Module support
Date: Fri, 18 Jan 2013 14:50:33 +0000
Message-ID: <201301181450.33444.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-49-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63551 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab3AROug (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:50:36 -0500
In-Reply-To: <1358511930-7424-49-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:

> +int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> +			      char *secstr, struct module *mod)
> +{
> +    return 0;
> +}
> +
> +void module_arch_cleanup(struct module *mod)
> +{
> +}
> +
> +int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
> +		    struct module *mod)
> +{
> +    return 0;
> +}

These three empty functions are already defined __weak in kernel/module.c
so you can simply omit them here.

	Arnd
