Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49200 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751489AbaDVOZN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 10:25:13 -0400
Date: Tue, 22 Apr 2014 11:24:43 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 06/28] nios2: Memory management
Message-ID: <20140422142443.GB15745@arch.cereza>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397824031-4892-5-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1397824031-4892-5-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140422142443.Embjmux0U2UFBXhGtrXaGIijUyOOkscpYSiLBmK6Av4@z>

Hi Ley Foon,

On Apr 18, Ley Foon Tan wrote:
> +/*
> + * PAGE_SHIFT determines the page size
> + */
> +#define PAGE_SHIFT	12
> +#define PAGE_SIZE	4096
> +#define PAGE_MASK	(~(PAGE_SIZE - 1))
> +

How about something like this:

/* PAGE_SHIFT determines the page size */
#define PAGE_SHIFT              12
#define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)
#define PAGE_MASK               (~((1 << PAGE_SHIFT) - 1))

Otherwise, the PAGE_SIZE macro above produces some warnings, IIRC.

-- 
Ezequiel García, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
