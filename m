Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGIFsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 01:48:46 -0400
Date: Mon, 9 Jul 2018 07:48:42 +0200
From: Greg KH <greg@kroah.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Message-ID: <20180709054842.GB7618@kroah.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709044444.6397-1-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Message-ID: <20180709054842.CA3ZOs9SxCQnxZYRKIWwugB2yKQjLUw2vzoZlkhzRqY@z>

On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
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

So is this something you hit today?  If not, why is this needed for
stable kernels?

> That's because even on CPUs capable of non-aligned data access LL/SC
> instructions require strict alignment.

Are you going to hit this code with all types of structures?  What
happens when you do have an unaligned access?

> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

You didn't cc: this address :(

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
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index f98a097e73f2..466fa59c866a 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -24,8 +24,12 @@ struct devres_node {
>  
>  struct devres {
>  	struct devres_node		node;
> -	/* -- 3 pointers */
> -	unsigned long long		data[];	/* guarantee ull alignment */
> +	/*
> +	 * Depending on ABI "long long" type of a particular 32-bit CPU
> +	 * might be aligned by either word (32-bits) or double word (64-bits).
> +	 * Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> +	 */
> +	unsigned long long		data[] __aligned(sizeof(unsigned long long));
>  };

Does this change the padding today for any other arches?  If so, does
the increased memory usage cause any noticable issues?

thanks,

greg k-h
