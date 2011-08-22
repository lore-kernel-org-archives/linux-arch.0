From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/24] C6X: loadable module support
Date: Mon, 22 Aug 2011 23:04:22 +0200
Message-ID: <2446000.E5C4Vbv39p@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-17-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64332 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab1HVVE4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 17:04:56 -0400
In-Reply-To: <1314043785-2880-17-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 22 August 2011 16:09:37 Mark Salter wrote:
> +/*
> + * apply a REL relocation
> + */
> +int apply_relocate(Elf32_Shdr *sechdrs,
> +                  const char *strtab,
> +                  unsigned int symindex,
> +                  unsigned int relsec,
> +                  struct module *me)
> +{

> +/*
> + * apply a RELA relocation
> + */
> +int apply_relocate_add(Elf32_Shdr *sechdrs,
> +                      const char *strtab,
> +                      unsigned int symindex,
> +                      unsigned int relsec,
> +                      struct module *me)
> +{

I have to admit that I don't really understand how the module loader
works, but I have noticed in the past that all architectures provide
only one of apply_relocate or apply_relocate_add.

Do you actually need both?

	Arnd
