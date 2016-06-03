From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [kernel-hardening] [PATCH 2/2] arm: apply more __ro_after_init
Date: Fri, 3 Jun 2016 11:51:06 -0700
Message-ID: <20160603185106.GB17076@kroah.com>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org>
 <1464979224-2085-3-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49267 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296AbcFCSvH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2016 14:51:07 -0400
Content-Disposition: inline
In-Reply-To: <1464979224-2085-3-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kernel-hardening@lists.openwall.com
Cc: Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mathias Krause <minipli@googlemail.com>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Jun 03, 2016 at 11:40:24AM -0700, Kees Cook wrote:
> Guided by grsecurity's analogous __read_only markings in arch/arm,
> this applies several uses of __ro_after_init to structures that are
> only updated during __init.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/kernel/cpuidle.c |  2 +-
>  arch/arm/kernel/setup.c   | 10 +++++-----
>  arch/arm/kernel/smp.c     |  2 +-
>  arch/arm/lib/delay.c      |  2 +-
>  arch/arm/mm/mmu.c         |  9 ++-------
>  arch/x86/mm/ioremap.c     |  3 +--

I don't think this x86 file is an arm-specific one :)

That minor nit aside, these patches are a great step forward, are you
going to take them and work to push them upstream, or do you want/need
others to do this?

thanks,

greg k-h
