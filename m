From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 04/24] C6X: build infrastructure
Date: Mon, 22 Aug 2011 22:55:09 +0200
Message-ID: <20110822205509.GA7940@merkur.ravnborg.org>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-5-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:43647 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab1HVUzL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 16:55:11 -0400
Content-Disposition: inline
In-Reply-To: <1314043785-2880-5-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

> 
> diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
> new file mode 100644
> index 0000000..f147a446
> --- /dev/null
> +++ b/arch/c6x/Kconfig
> @@ -0,0 +1,179 @@
> +#
> +# For a description of the syntax of this configuration file,
> +# see Documentation/kbuild/kconfig-language.txt.
> +#
> +
> +config TMS320C6X
> +	def_bool y
> +	select CLKDEV_LOOKUP
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
Not present in todays kernel - not even if you try to select it twice

> +	select GENERIC_HARDIRQS_NO_DEPRECATED
Not present either - drop it.

> +
> +menu "Processor type and features"
> +
> +config TMS320C64XPLUS
> +	bool "TMS320C64X+"
A little help would be nice. Maybe with a pointer to a web-site.

> +cflags-y := -D__linux__ -D__TMS320C6X__

Why is __linux__ and __TMS3206C6X__ neeeded?
and why are they not needed for CHECKFLAGS ?

Other than this it looks good!

	Sam
