Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:54429 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756469AbXKPL2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 06:28:00 -0500
Date: Fri, 16 Nov 2007 12:27:17 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: + aout-mark-arches-that-support-aout-format.patch added to -mm
 tree
Message-ID: <20071116122717.062314f5@siona>
In-Reply-To: <200711152352.lAFNqkQp022343@imap1.linux-foundation.org>
References: <200711152352.lAFNqkQp022343@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, dhowells@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 15 Nov 2007 15:52:46 -0800
akpm@linux-foundation.org wrote:

> diff -puN
> arch/avr32/Kconfig~aout-mark-arches-that-support-aout-format
> arch/avr32/Kconfig ---
> a/arch/avr32/Kconfig~aout-mark-arches-that-support-aout-format +++
> a/arch/avr32/Kconfig @@ -67,6 +67,9 @@ config GENERIC_BUG default y
>  	depends on BUG
>  
> +config ARCH_SUPPORTS_AOUT
> +	def_bool y
> +

Might as well define this one as "n" too. AVR32 will never support
a.out.

Håvard
