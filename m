Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:59931 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab1FYFBi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 25 Jun 2011 01:01:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 14/19] OpenRISC: Module support
In-Reply-To: <201106241205.32037.arnd@arndb.de>
References: <1308483825-6023-1-git-send-email-jonas@southpole.se> <201106221626.12023.arnd@arndb.de> <1308905525.6699.23.camel@localhost> <201106241205.32037.arnd@arndb.de>
Date: Fri, 24 Jun 2011 20:36:31 +0930
Message-ID: <874o3f8p54.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110624110631.OydWbfWiaPROvXREVzrPTTN5elh14Y9RXpKVT02xPbY@z>

On Fri, 24 Jun 2011 12:05:31 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 24 June 2011, Jonas Bonn wrote:
> > I noticed that kernel/module.c already has this:
> > 
> > unsigned int __weak arch_mod_section_prepend(struct module *mod,
> >                                              unsigned int section)
> > 
> >
> > Is using a __weak attribute on the default (generic) implementations a
> > better approach?
> 
> I normally don't like using __weak, because it more easily confuses
> readers about which version is actually used.

I share your reluctance with __weak, but as fewer people want to touch
multiple archs it is becoming the norm.

Would happily accept patches...

Thanks,
Rusty.
