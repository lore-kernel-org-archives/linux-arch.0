Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38233 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932563AbeGHSky (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Jul 2018 14:40:54 -0400
Date: Sun, 8 Jul 2018 20:40:49 +0200
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] devres: Really align data field to unsigned long long
Message-ID: <20180708184049.GA1645@kroah.com>
References: <20180708175621.6951-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708175621.6951-1-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <alexey.brodkin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Message-ID: <20180708184049.5pib3W4j159Zwa1KNkGWwvBUiEGWdxTnm7yKnr97lvE@z>

On Sun, Jul 08, 2018 at 08:56:21PM +0300, Alexey Brodkin wrote:
> Depending on ABI "long long" type of a particular 32-bit CPU
> might be aligned by either word (32-bits) or double word (64-bits).
> Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> 
> At least for 32-bit ARC cores ABI requires "long long" types
> to be aligned by normal 32-bit word. This makes "data" field aligned to
> 12 bytes. Which is still OK as long as we use 32-bit data only.
> 
> But once we want to use native atomic64_t type (i.e. when we use special
> instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> misaligned access exception.
> 
> That's because even on CPUs capable of non-aligned data access LL/SC
> instructions require strict alignment.
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
> 
> Changes v1 -> v2:
> 
>  * Reworded commit message
>  * Inserted comment right in source [Thomas]
> 
>  drivers/base/devres.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Always use scripts/get_maintainer.pl to properly cc: the needed
developer/maintainer.  As it is, this patch is going to get dropped on
the floor, sorry...

greg k-h
