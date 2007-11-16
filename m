Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:47069 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765110AbXKPAH5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 19:07:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18236.57173.988901.37472@cargo.ozlabs.ibm.com>
Date: Fri, 16 Nov 2007 11:07:49 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: + aout-mark-arches-that-support-aout-format.patch added to -mm tree
In-Reply-To: <200711152352.lAFNqkQp022343@imap1.linux-foundation.org>
References: <200711152352.lAFNqkQp022343@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, dhowells@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

akpm@linux-foundation.org writes:

> The patch titled
>      AOUT: Mark arches that support A.OUT format
> has been added to the -mm tree.  Its filename is
>      aout-mark-arches-that-support-aout-format.patch

> diff -puN arch/powerpc/Kconfig~aout-mark-arches-that-support-aout-format arch/powerpc/Kconfig
> --- a/arch/powerpc/Kconfig~aout-mark-arches-that-support-aout-format
> +++ a/arch/powerpc/Kconfig
> @@ -76,6 +76,9 @@ config GENERIC_FIND_NEXT_BIT
>  config ARCH_NO_VIRT_TO_BUS
>  	def_bool PPC64
>  
> +config ARCH_SUPPORTS_AOUT
> +	def_bool y
> +

Neither powerpc nor ppc actually support a.out at all, nor have they
ever supported it.

Paul.
