From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 17/27] add generic lib/checksum.c
Date: Fri, 1 May 2009 10:20:27 +0100
Message-ID: <20090501092027.GA29366@flint.arm.linux.org.uk>
References: <cover.1241105648.git.arnd@arndb.de> <cda5746ab12cf9d6bcb7803a3667c92250a29784.1241105648.git.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33267 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbZEAJUi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 05:20:38 -0400
Content-Disposition: inline
In-Reply-To: <cda5746ab12cf9d6bcb7803a3667c92250a29784.1241105648.git.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Tue, Mar 31, 2009 at 03:30:31PM +0200, Arnd Bergmann wrote:
> +/*
> + * copy from fs while checksumming, otherwise like csum_partial
> + */
> +__wsum
> +csum_partial_copy_from_user(const void __user *src, void *dst, int len,
> +						__wsum sum, int *csum_err)
> +{
> +	if (csum_err)
> +		*csum_err = 0;
> +	memcpy(dst, src, len);

Since when has 'memcpy' been valid from user addresses?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
