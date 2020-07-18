From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Date: Sat, 18 Jul 2020 07:54:37 -0700
Message-ID: <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net>
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net>
 <20200718094846.GA8593@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200718094846.GA8593@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 7/18/20 2:48 AM, Christoph Hellwig wrote:
> On Fri, Jul 17, 2020 at 06:38:50PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Tue, Jul 14, 2020 at 12:55:00PM +0200, Christoph Hellwig wrote:
>>> Use the uaccess_kernel helper instead of duplicating it.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> This patch causes a severe hiccup with my mps2-an385 boot test.
> 
> I guess that is a nommu config?
> 
Correct.

> Can you try this patch?
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index b19c9bec1f7a63..cc7daf374a6eb6 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -263,7 +263,7 @@ extern int __put_user_8(void *, unsigned long long);
>   */
>  #define USER_DS			KERNEL_DS
>  
> -#define uaccess_kernel()	(true)
> +#define uaccess_kernel()	(false)
>  #define __addr_ok(addr)		((void)(addr), 1)
>  #define __range_ok(addr, size)	((void)(addr), 0)
>  #define get_fs()		(KERNEL_DS)
> 

With this change, the error message is gone. However, it still does not
work. The image just hangs instead.

Guenter
