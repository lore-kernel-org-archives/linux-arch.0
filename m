From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dma-mapping: Add BUG_ON for uninitialized dma_ops
Date: Wed, 12 Jun 2013 17:06:39 +0200
Message-ID: <201306121706.39368.arnd@arndb.de>
References: <f35c5051a207b0a117f2fff27365d0ea892d1610.1370263476.git.michal.simek@xilinx.com> <51B703D7.8050804@samsung.com> <1370958858.2286.5.camel@dabdike>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58808 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3FLPGp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jun 2013 11:06:45 -0400
In-Reply-To: <1370958858.2286.5.camel@dabdike>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Linux-Arch <linux-arch@vger.kernel.org>

On Tuesday 11 June 2013, James Bottomley wrote:
> Really, no, it's not a good idea at all.  It invites tons of patches
> littering the code with BUG_ONs where we might possibly get a NULL
> dereference.  All it does is add extra instructions to a code path for
> no actual benefit.
> 
> If you can answer the question: what more information does the BUG_ON
> give you than the NULL deref Oops would not? then it might be
> reasonable.

The question is if a user can trigger the NULL dereference intentionally,
in which case they might get the kernel to jump into a  user-provided
buffer.

	Arnd
