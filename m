From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] io: correct documentation mismatches for io memcpy
Date: Thu, 23 Apr 2020 10:02:39 -0700
Message-ID: <84b453cb-886c-2ec6-e562-e300a3cd55d4@infradead.org>
References: <20200423000945.118231-1-wenhu.wang@vivo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgDWRCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Apr 2020 13:02:43 -0400
In-Reply-To: <20200423000945.118231-1-wenhu.wang@vivo.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wang Wenhu <wenhu.wang@vivo.com>, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@vivo.com

On 4/22/20 5:09 PM, Wang Wenhu wrote:
> Minor mismatches exist between funtion documentations and parameter
> definitions. Also a dash '-' is needed between a function name and
> its description.
> 
> Function definitions are as following:
> static inline void memcpy_fromio(void *buffer,
> 				 const volatile void __iomem *addr,
> 				 size_t size)
> static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
> 			       size_t size)
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Hi,
Sorry to just notice this, but could you also fix up all of
the kernel-doc notation for memset_io() in the same manner?

thanks.

> ---
> Changes since v1:
>  * Dashes added between the function names and their descriptions.
> 
>  include/asm-generic/io.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d39ac997dda8..b6a9131ec4d4 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1066,10 +1066,10 @@ static inline void memset_io(volatile void __iomem *addr, int value,
>  #ifndef memcpy_fromio
>  #define memcpy_fromio memcpy_fromio
>  /**
> - * memcpy_fromio	Copy a block of data from I/O memory
> - * @dst:		The (RAM) destination for the copy
> - * @src:		The (I/O memory) source for the data
> - * @count:		The number of bytes to copy
> + * memcpy_fromio -	Copy a block of data from I/O memory
> + * @buffer:		The (RAM) destination for the copy
> + * @addr:		The (I/O memory) source for the data
> + * @size:		The number of bytes to copy
>   *
>   * Copy a block of data from I/O memory.
>   */
> @@ -1084,10 +1084,10 @@ static inline void memcpy_fromio(void *buffer,
>  #ifndef memcpy_toio
>  #define memcpy_toio memcpy_toio
>  /**
> - * memcpy_toio		Copy a block of data into I/O memory
> - * @dst:		The (I/O memory) destination for the copy
> - * @src:		The (RAM) source for the data
> - * @count:		The number of bytes to copy
> + * memcpy_toio -	Copy a block of data into I/O memory
> + * @addr:		The (I/O memory) destination for the copy
> + * @buffer:		The (RAM) source for the data
> + * @size:		The number of bytes to copy
>   *
>   * Copy a block of data to I/O memory.
>   */
> 


-- 
~Randy
