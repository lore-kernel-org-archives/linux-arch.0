From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Make most arch asm/module.h files use asm-generic/module.h [ver #2]
Date: Thu, 19 Jul 2012 12:40:46 +0100
Message-ID: <31321.1342698046@warthog.procyon.org.uk>
References: <20105.1342623053@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab2GSLlN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2012 07:41:13 -0400
In-Reply-To: <20105.1342623053@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Sam Ravnborg <sam@ravnborg.org>, Fengguang Wu <fengguang.wu@intel.com>


David Howells <dhowells@redhat.com> wrote:

> +static inline int apply_relocate(Elf_Shdr *sechdrs,
> +				 const char *strtab,
> +				 unsigned int symindex,
> +				 unsigned int relsec,
> +				 struct module *me)
> +{
> +	pr_err("module %s: REL relocation unsupported\n", me->name);
> +	return -ENOEXEC;
> +}

Turns out you cannot use pr_err() and friends in a header file, lest it get
included in a file that defines pr_fmt() to be something inconvenient.

Thanks to Fengguang and his GIT tree cruncher for finding this in Blackfin
with the BF526-EZBRD_defconfig.

David
