Return-Path: <arun.sharma@intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:63454 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264895AbUFRA4v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Jun 2004 20:56:51 -0400
Message-ID: <40D23DC3.5080005@intel.com>
Date: Thu, 17 Jun 2004 17:56:35 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: sys getdents64 needs compat wrapper ?
References: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de> <40CDEB59.3040203@intel.com> <40D21B17.4060603@intel.com> <200406180136.34384.arnd@arndb.de>
In-Reply-To: <200406180136.34384.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 6/17/2004 4:36 PM, Arnd Bergmann wrote:

> On Freitag, 18. Juni 2004 00:28, Arun Sharma wrote:
> 
>>It took us a bit longer :) But here's the promised patch. Using
>>__put_user_unaligned() on ia64 may still cause unaligned faults,
>>but we chose to optimize for the common case, where it's 4 byte
>>aligned.   
> 
> 
> Isn't it legal for i386 code to pass syscall arguments with
> an arbitrary alignment? I guess gcc normally aligns everything
> to 32 bit unless you force it not to but you might still return
> error for syscalls that work fine on a native i386 system.
> 

We don't return error, we just take an unaligned fault for this case.

> 
>>+ */
>>+#define __get_user_unaligned(x, ptr)                                   \
>>+({                                                                     \
>>+       __typeof__ (*(ptr)) __x = (x);                                  \
>>+       copy_from_user(&__x, (ptr), sizeof(*(ptr))) ? -EFAULT : 0;      \
>>+})
> 
> 
> This should be __copy_from_user instead of copy_from_user, right?
> 

Yes, will fix.

> Under what circumstances would you need to break down a 4 byte
> alignment into 2 bytes? I can understand that you want to optimize
> the unaligned-64 bit case because i386-gcc aligns them only to 32 bit
> in user space, but the other special cases are bogus. Why not
> just do:

I agree that it's unlikely to be used, but I put it in there for completeness. For eg: <asm-ia64/unaligned.h> is doing this too.

> 
> ppc64 and s390 both don't care about alignment, so simply using
> 
> #define __get_user_unaligned __get_user
> #define __put_user_unaligned __put_user
> 
> would make more sense here. See include/asm-*/unaligned.h
> 
> 
>>diff -purN -X dontdiff linux-2.6.7-rc3-getdents/include/asm-x86_64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-x86_64/uaccess.h
>>--- linux-2.6.7-rc3-getdents/include/asm-x86_64/uaccess.h       2004-06-15 13:41:34.000000000 +0800
>>+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-x86_64/uaccess.h        2004-06-17 14:51:42.022553572 +0800
>>@@ -10,6 +10,7 @@
>> #include <linux/sched.h>
>> #include <linux/prefetch.h>
>> #include <asm/page.h>
>>+#include <asm-generic/uaccess.h>
>> 
>> #define VERIFY_READ 0
>> #define VERIFY_WRITE 1
> 
> 
> Same on x86_64.

Will update the patch for other archs as well.

	-Arun
