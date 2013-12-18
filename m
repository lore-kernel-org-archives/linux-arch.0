Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64601 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab3LRKkQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2013 05:40:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Create generic early_ioremap() support
Date: Wed, 18 Dec 2013 11:40:00 +0100
References: <1385606679-30446-1-git-send-email-msalter@redhat.com> <1387305938.1979.166.camel@deneb.redhat.com> <20131218091348.GB15594@dhcp-16-126.nay.redhat.com>
In-Reply-To: <20131218091348.GB15594@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201312181140.01134.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20131218104000.7Ffb0qPMI_-4FGywfehkmpgGm-vW4oyCV1iTyPXSITA@z>

On Wednesday 18 December 2013, Dave Young wrote:
> > 
> > I hadn't really thought about it. Putting these things in mm doesn't
> > sound unreasonable, but lib seems to have become the place for a lot
> > generic code which could also belong in mm, net, etc.
> > 
> 
> IMHO, move subsystem lib code to subsystem core dir looks more reasonable.
> lib should be the place for general kernel stuff.
> 
> I'm not specific for and object this patch, just give my opinion about the lib/..

Traditionally, lib/ is for things that may or may not be used by other optional
code, typically drivers, which I think is a reasonable concept. There has been
some shift over the years from lib-$(CONFIG_FOO) towards obj-$(CONFIG_FOO),
so it's not always used as a actual library code in the linker sense though.

I would agree that moving mm related code such as early_ioremap into mm/ is
a good idea. For things like the compression helpers lib/ is probably
still the best place.

	Arnd
