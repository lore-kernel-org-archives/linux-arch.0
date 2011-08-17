From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/24] C6X: memory management
Date: Wed, 17 Aug 2011 15:34:35 +0200
Message-ID: <201108171534.36007.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <201108091827.40045.arnd@arndb.de> <1313587573.2306.12.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54302 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1HQNel (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2011 09:34:41 -0400
In-Reply-To: <1313587573.2306.12.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Wednesday 17 August 2011, Mark Salter wrote:
> C6X is never consistent in that there is no hw snooping between main
> memory and L2 cache. There is some cache control however which allows
> us to create a pool of uncached memory for use as consistent DMA memory.
> I think the __dma_is_coherent tries to tell at runtime if the dma handle
> comes from such a pool of consistent memory.
> 
> I'm not aware of any drivers actually needing this although I'm sure TI
> has some. For the purpose of getting the arch accepted, I could just
> punt and take it out for now, simplifying the dma support. It can be
> revisited later if needed.

Yes, sounds good. Not sure if you meant removing all calls to
arch_is_coherent() as well, but I'd suggest you do that, too.
This should further simplify the code by removing code paths
that are unused and untested.

	Arnd
