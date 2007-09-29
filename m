Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:62845 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbXI2Js4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Sep 2007 05:48:56 -0400
Date: Sat, 29 Sep 2007 11:48:52 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [COMPAT] Add compat_merge64 helper
Message-ID: <20070929094852.GA7715@osiris.boeblingen.de.ibm.com>
References: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Sep 28, 2007 at 06:33:51PM -0400, Kyle McMartin wrote:
> To be used when endianness matters for argument ordering when reassembling
> a 64-bit value out of two register halves.
> 
> Signed-off-by: Kyle McMartin <kyle@mcmartin.ca>
>
> +static inline u64 compat_merge64(u32 left, u32 right)
> +{
> +#if defined(__BIG_ENDIAN)
> +	return ((u64)left << 32) | right;
> +#else /* defined (__LITTLE_ENDIAN) */

Could you change that to an #elif please and #error out if none is defined?
Should safe us from subtle bugs caused by missing includes.
