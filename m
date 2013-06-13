From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-mapping: Add BUG_ON for uninitialized dma_ops
Date: Thu, 13 Jun 2013 10:51:30 +0200
Message-ID: <51B98812.80201@samsung.com>
References: <f35c5051a207b0a117f2fff27365d0ea892d1610.1370263476.git.michal.simek@xilinx.com>
 <51B703D7.8050804@samsung.com> <1370958858.2286.5.camel@dabdike>
 <201306121706.39368.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:42634 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab3FMIve (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jun 2013 04:51:34 -0400
In-reply-to: <201306121706.39368.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Linux-Arch <linux-arch@vger.kernel.org>


On 6/12/2013 5:06 PM, Arnd Bergmann wrote:
> On Tuesday 11 June 2013, James Bottomley wrote:
> > Really, no, it's not a good idea at all.  It invites tons of patches
> > littering the code with BUG_ONs where we might possibly get a NULL
> > dereference.  All it does is add extra instructions to a code path for
> > no actual benefit.
> >
> > If you can answer the question: what more information does the BUG_ON
> > give you than the NULL deref Oops would not? then it might be
> > reasonable.
>
> The question is if a user can trigger the NULL dereference intentionally,
> in which case they might get the kernel to jump into a  user-provided
> buffer.

I don't any possibility for userspace to alter the ops pointer, so if you
think that BUG_ON() approach causes additional overhead then I'm fine to
remove it.

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
