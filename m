Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48484 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbcC3NaK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Mar 2016 09:30:10 -0400
MIME-Version: 1.0
In-Reply-To: <6282729.XLLXSxbzQJ@wuerfel>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
 <6746826.YZLTqKTgkv@wuerfel> <56FB8AC1.4070209@nod.at> <6282729.XLLXSxbzQJ@wuerfel>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Mar 2016 08:29:45 -0500
Message-ID: <CAL_Jsq+RHwzxfoEFsD_-uAZ7Y_CEdXvv8qamdXtcToeG-ENy7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Weinberger <richard@nod.at>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
Message-ID: <20160330132945.Ij6R2uj2I8uZleHFKRM8qhsCiUt1ghOPQ2cbDJvZU8Y@z>

On Wed, Mar 30, 2016 at 5:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 30 March 2016 10:13:53 Richard Weinberger wrote:
>>
>> I fully understand your point of view. COMPILE_TEST is a monster that
>> can do the heavy lifting for you, but monsters also have claws and fangs.
>>
>> Having COMPILE_TEST having depend on !UML works for me. But don't
>> we have other archs without io mem? At least a few years ago while
>> porting nandsim to UML I found s390 that lacks of io mem too.
>
> s390 gained IOMEM support when they started having PCI attachments.

I'm confused how s390 defines HAS_IOMEM and includes it from lib/Kconfig though.

> arch/score selects NO_IOMEM, though they do in fact use MMIO, and
> I'm sure their architecture has lots of other problems with build
> testing that nobody cares about.
>
> arch/tile can select NO_IOMEM when PCI is disabled, they might
> care about this, though I think they also have other build-time
> issues.
>
>> Maybe we depend COMPILE_TEST on HAS_IOMEM?
>
> That sounds fine with me as well.

That or !UML is fine, but I still think we should rid drivers from
depending on HAS_IOMEM. We probably still have cases where the only
dependency besides the driver's subsystem is HAS_IOMEM.

Rob
