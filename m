Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34784 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760579AbYDKSKa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2008 14:10:30 -0400
Date: Fri, 11 Apr 2008 19:09:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCHv2 1/8] kernel: add common infrastructure for unaligned access
Message-ID: <20080411180928.GA9137@flint.arm.linux.org.uk>
References: <1207856646.22001.25.camel@brick> <1207872394.22001.69.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1207872394.22001.69.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080411180928.4fHGZng-Z8OFPXA8bzXuHiekd3DaEUirrayHTndNBOE@z>

On Thu, Apr 10, 2008 at 05:06:34PM -0700, Harvey Harrison wrote:
> +#define __get_unaligned_cpu(ptr) ({			\
> +	const void *__gu_p = (ptr);			\
> +	typeof(*(ptr)) __val;				\
> +	switch (sizeof(*(ptr))) {			\
> +	case 1:						\
> +		__val = *(const u8 *)__gu_p;		\
> +		break;					\
> +	case 2:						\
> +		__val = __get_unaligned_cpu16(__gu_p);	\
> +		break;					\
> +	case 4:						\
> +		__val = __get_unaligned_cpu32(__gu_p);	\
> +		break;					\
> +	case 8:						\
> +		__val = __get_unaligned_cpu64(__gu_p);	\
> +		break;					\
> +	default:					\
> +		BUILD_BUG_ON(1);			\
> +		break;					\
> +	};						\
> +	__val; })

This won't work - on ARM we used to use this style, but it fails in
some corner case, so we ended up switching to using GCC's
__builtin_choose_expr() instead.

Such a corner case:

static unsigned long foo(const unsigned long *ptr)
{
	return __get_unaligned_cpu(ptr);
}

This results in '__val' being declared as const, and therefore the
compiler errors out in the switch statement since the code tries to
assign to a const '__val'.

See 17b602b1c1a38f3f0a4461bb1f571346e751b36b.

So, for the present set of patches, NAK for changing ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
