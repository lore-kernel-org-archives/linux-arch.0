Return-Path: <arun.sharma@intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:17358 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263745AbUFNSQK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2004 14:16:10 -0400
Message-ID: <40CDEB59.3040203@intel.com>
Date: Mon, 14 Jun 2004 11:15:53 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: sys getdents64 needs compat wrapper ?
References: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de> <20040604172816.259f38e8.davem@redhat.com> <40C4DA5E.8090700@intel.com> <200406111709.35146.arnd@arndb.de>
In-Reply-To: <200406111709.35146.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 6/11/2004 8:09 AM, Arnd Bergmann wrote:
> 
>>+       if (dirent) {
>>+               if ((__put_user(offset, (u32 __user *)&dirent->d_off))
>>+                || (__put_user(offset >> 32, ((u32 __user *)&dirent->d_off) + 1)))
>>+                       goto efault;
>>+       }
> 
> 
> I just realized your code is broken on big-endian architectures, so
> we should either get back to __copy_to_user or find the optimal solution
> now.
> 
> How about a {__,}{get,put}_user_unaligned() that gets defined per
> architecture in one of these two ways:

We'll go for the optimal solution now. We'll provide an <asm-generic/uaccess.h> that does __copy_to_user and a <asm-ia64/uaccess.h> that's optimized for ia64. Archs which don't care about alignment can override appropriately.

Should have the patch tested by tomorrow.

	-Arun
