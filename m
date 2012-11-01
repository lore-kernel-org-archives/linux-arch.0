From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 31/40] char: don't build rtc or genrtc on METAG
Date: Thu, 1 Nov 2012 08:39:49 -0700
Message-ID: <20121101153949.GA8529@kroah.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
 <1351700061-7203-32-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33437 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771Ab2KAPjx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 11:39:53 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1801034pad.19
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2012 08:39:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351700061-7203-32-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Wed, Oct 31, 2012 at 04:14:12PM +0000, James Hogan wrote:
> The metag architecture doesn't have a PC RTC or implement the RTC
> interface that genrtc expects, so add METAG to the list of architectures
> not to build RTC or GEN_RTC on.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> ---
>  drivers/char/Kconfig |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index ea6f632..09b64a8 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -283,7 +283,8 @@ if RTC_LIB=n
>  config RTC
>  	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
>  	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
> -			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
> +			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN \
> +			&& !UML && !METAG

This is getting huge, would it be easier to reverse it and just list the
arches that it does work for?

thanks,

greg k-h
