From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Wed, 30 Mar 2016 15:51:19 +0200
Message-ID: <5372571.zc5TeOVXyF@wuerfel>
References: <1459275781-3863-1-git-send-email-robh@kernel.org> <6282729.XLLXSxbzQJ@wuerfel> <CAL_Jsq+RHwzxfoEFsD_-uAZ7Y_CEdXvv8qamdXtcToeG-ENy7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:51906 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbcC3Nvj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2016 09:51:39 -0400
In-Reply-To: <CAL_Jsq+RHwzxfoEFsD_-uAZ7Y_CEdXvv8qamdXtcToeG-ENy7w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 30 March 2016 08:29:45 Rob Herring wrote:
> On Wed, Mar 30, 2016 at 5:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 30 March 2016 10:13:53 Richard Weinberger wrote:
> >>
> >> I fully understand your point of view. COMPILE_TEST is a monster that
> >> can do the heavy lifting for you, but monsters also have claws and fangs.
> >>
> >> Having COMPILE_TEST having depend on !UML works for me. But don't
> >> we have other archs without io mem? At least a few years ago while
> >> porting nandsim to UML I found s390 that lacks of io mem too.
> >
> > s390 gained IOMEM support when they started having PCI attachments.
> 
> I'm confused how s390 defines HAS_IOMEM and includes it from lib/Kconfig though.

Kconfig can define the same symbol multiple times, which is really
confusing. I only checked for NO_IOMEM, which s390 no longer defines,
but I have not checked what actually happens in case of two conflicting
definitions, where the one lib/Kconfig defaults to 'y' and the one in
arch/s390 defaults to CONFIG_PCI.

	Arnd
