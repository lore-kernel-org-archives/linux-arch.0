Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36200 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbeKTLO0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Nov 2018 06:14:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id y6-v6so106870plt.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Nov 2018 16:48:03 -0800 (PST)
Date: Mon, 19 Nov 2018 16:48:02 -0800 (PST)
Subject: Re: [PATCH 2/2] arch: switch the default on ARCH_HAS_SG_CHAIN
In-Reply-To: <20181119135852.GA16428@lst.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-bc691596-d40e-4dd5-b162-b767e550b92e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181120004802.8MMMlPriFhI4Ih0tD-xvgiPMsW1vNEHpULyaPcyr6HM@z>

On Mon, 19 Nov 2018 05:58:52 PST (-0800), Christoph Hellwig wrote:
> On Fri, Nov 16, 2018 at 08:52:14AM -0800, Palmer Dabbelt wrote:
>> As far as I can tell, it looks like m68k, mips, and powerpc mention an
>> IOMMU in their ports, don't set ARCH_HAS_SG_CHAIN, and with this patch set
>> won't set ARCH_NO_SG_CHAIN.
>
> m68k has no iommu, and not operations that operate on a scatterlist.
>
> mips has a trivial iommu driver (jazzdma), but I wrote the current
> instance of it, nad it is fine.
>
> powerpc has various iommu, but actually enables ARCH_HAS_SG_CHAIN
> unconditionally.
>
>> The issue is that I'm not sure how to
>> determine what constitutes a horrible legacy IOMMU, at least with respect
>> to not being able to use scatterlist chaining.
>
> It basically means someone is iterating using manual pointer arithmetics
> over a multi-element scatterlist instead of using the sg_next and
> for_each_sg helpers.

Ah, OK.  In that case, feel free to drop a

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

in there, if you think it helps any.

Thanks for the help!
