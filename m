Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38155 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbYHLCER (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Aug 2008 22:04:17 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 1/3] add support for exporting symbols from .S files
Date: Tue, 12 Aug 2008 12:03:56 +1000
References: <200808111606.44103.arnd@arndb.de> <200808111618.08206.arnd@arndb.de>
In-Reply-To: <200808111618.08206.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200808121203.57182.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, David Woodhouse <dwmw2@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@ozlabs.org
Message-ID: <20080812020356.BfdVL0Hzm3KlBc-wZK45ih4tVtZwZhyD5Czm47OpExQ@z>

On Tuesday 12 August 2008 00:18:07 Arnd Bergmann wrote:
> This makes it possible to export symbols from assembly files, instead
> of having to export them through an extra ksyms.c file.
>
> I found this nicer to implement using a gas macro than a cpp macro.
...
> +	.ifeq BITS_PER_LONG-32
> +	.align 3
> +\symtab:
> +	.long \sym
> +	.long \strtab
> +	.else
> +	.align 4

Good work!   Hmm, you can .balign BITS_PER_LONG/8 outside the ifeq.  
Unfortunately .long doesn't do the Right Thing on 64 bit, so getting rid of 
the if is harder.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Cheers,
Rusty.
