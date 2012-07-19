From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] Make most arch asm/module.h files use
 asm-generic/module.h [ver #2]
Date: Thu, 19 Jul 2012 21:07:03 +0800
Message-ID: <20120719130703.GA17751@localhost>
References: <20105.1342623053@warthog.procyon.org.uk>
 <31321.1342698046@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33431 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab2GSNHL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2012 09:07:11 -0400
Content-Disposition: inline
In-Reply-To: <31321.1342698046@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Sam Ravnborg <sam@ravnborg.org>, uclinux-dist-devel@blackfin.uclinux.org, Mike Frysinger <vapier@gentoo.org>

On Thu, Jul 19, 2012 at 12:40:46PM +0100, David Howells wrote:
> 
> David Howells <dhowells@redhat.com> wrote:
> 
> > +static inline int apply_relocate(Elf_Shdr *sechdrs,
> > +				 const char *strtab,
> > +				 unsigned int symindex,
> > +				 unsigned int relsec,
> > +				 struct module *me)
> > +{
> > +	pr_err("module %s: REL relocation unsupported\n", me->name);
> > +	return -ENOEXEC;
> > +}
> 
> Turns out you cannot use pr_err() and friends in a header file, lest it get
> included in a file that defines pr_fmt() to be something inconvenient.
> 
> Thanks to Fengguang and his GIT tree cruncher for finding this in Blackfin
> with the BF526-EZBRD_defconfig.

For completeness, here are the error messages and David's comments:

>> In file included from arch/blackfin/kernel/module.c:9:0:
>> include/linux/moduleloader.h: In function 'apply_relocate':
>> include/linux/moduleloader.h:48:2: error: 'mod' undeclared (first use in this function)
>> include/linux/moduleloader.h:48:2: note: each undeclared identifier is reported only once for each function it appears in
>
>pr_err() is the problem.  If you're in a file that defines pr_fmt then it will
>use that.  At the top of arch/blackfin/kernel/module.c:
>
>        #define pr_fmt(fmt) "module %s: " fmt, mod->name
>
>I guess you can't use pr_err() in header files.

Thanks,
Fengguang
