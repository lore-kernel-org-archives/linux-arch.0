Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from holomorphy.com ([66.93.40.71]:18902 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1422787AbWHXX6L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Aug 2006 19:58:11 -0400
Date: Thu, 24 Aug 2006 16:58:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Message-ID: <20060824235806.GD3580@holomorphy.com>
References: <20060824234445.6B519D52@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824234445.6B519D52@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> diff -puN mm/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT mm/Kconfig
> +config PAGE_SHIFT
> +	int
> +	default "13" if PAGE_SIZE_8KB || ALPHA || SUN3 || SUN4
> +	default "14" if PAGE_SIZE_16KB || FRV || CRIS
> +	default "16" if PAGE_SIZE_64KB || FRV || CRIS
> +	default "19" if PAGE_SIZE_512KB
> +	default "22" if PAGE_SIZE_4MB
> +	default "12" # arm || h8300 || i386 | m68knommu |ppc
> +		     # s390 || um || v850 || xtensa

You can't be serious.

Stuffing incomplete tables of logarithms in mm/Kconfig is not the way.


-- wli
