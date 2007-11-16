Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:22683 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbXKPJl3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 04:41:29 -0500
Subject: Re: + aout-mark-arches-that-support-aout-format.patch added to -mm
	tree
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200711152352.lAFNqkQp022343@imap1.linux-foundation.org>
References: <200711152352.lAFNqkQp022343@imap1.linux-foundation.org>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 10:40:38 +0100
Message-Id: <1195206038.23776.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, dhowells@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2007-11-15 at 15:52 -0800, akpm@linux-foundation.org wrote:
> The patch titled
>      AOUT: Mark arches that support A.OUT format
> has been added to the -mm tree.  Its filename is
>      aout-mark-arches-that-support-aout-format.patch
>
> diff -puN arch/s390/Kconfig~aout-mark-arches-that-support-aout-format arch/s390/Kconfig
> --- a/arch/s390/Kconfig~aout-mark-arches-that-support-aout-format
> +++ a/arch/s390/Kconfig
> @@ -47,6 +47,9 @@ config NO_IOMEM
>  config NO_DMA
>  	def_bool y
> 
> +config ARCH_SUPPORTS_AOUT
> +	def_bool n
> +
>  mainmenu "Linux Kernel Configuration"
> 
>  config S390

There never has been an a.out binary on s390 and very probably there
never will be ..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


