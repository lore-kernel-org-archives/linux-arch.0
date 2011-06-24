From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/19] OpenRISC: Module support
Date: Fri, 24 Jun 2011 12:05:31 +0200
Message-ID: <201106241205.32037.arnd@arndb.de>
References: <1308483825-6023-1-git-send-email-jonas@southpole.se> <201106221626.12023.arnd@arndb.de> <1308905525.6699.23.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50828 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab1FXKFh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2011 06:05:37 -0400
In-Reply-To: <1308905525.6699.23.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>

On Friday 24 June 2011, Jonas Bonn wrote:
> On Wed, 2011-06-22 at 16:26 +0200, Arnd Bergmann wrote:
> > I think that an easy way to do that would be to add to kernel/module.c
> > code like:
> > 
> > #ifndef module_alloc
> > void *module_alloc(unsigned long size)
> > {
> >       return vmalloc(size);
> > }
> > #endif
> > 
> 
> I noticed that kernel/module.c already has this:
> 
> unsigned int __weak arch_mod_section_prepend(struct module *mod,
>                                              unsigned int section)
> 
>
> Is using a __weak attribute on the default (generic) implementations a
> better approach?

I normally don't like using __weak, because it more easily confuses
readers about which version is actually used.

> > Then each architecture that needs a special version can do
> > #define module_alloc(size) module_alloc(size)
> > in their respective asm/module.h
> 
> With the __weak variant this wouldn't be necessary...

Correct. I certainly wouldn't want to see both methods mixed in the
same file. Rusty is maintaining the module loader, maybe he has
a preference.

Rusty, we were discussing the fact that most module loader files
are providing very similar (mostly empty) functions, and that it would
be nice if the new openrisc architecture would only have to provide
apply_relocate_add(), which is actually arch specific, while it could
be changed to use the defaults for everything else.

	Arnd
