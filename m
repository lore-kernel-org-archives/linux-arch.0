From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] io: correct documentation mismatches for io memcpy
Date: Wed, 22 Apr 2020 09:42:56 -0700
Message-ID: <4b0a80ed-a639-c8c0-e6c3-01ba3266b7de@infradead.org>
References: <20200422092905.39529-1-wenhu.wang@vivo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgDVQm5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 12:42:57 -0400
In-Reply-To: <20200422092905.39529-1-wenhu.wang@vivo.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wang Wenhu <wenhu.wang@vivo.com>, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@vivo.com

Hi--

2 small nits: please see below.

On 4/22/20 2:29 AM, Wang Wenhu wrote:
> Minor mismatches exist between funtion documentations and parameter
> definitions.
> 
> Function definition lines are as following:
> static inline void memcpy_fromio(void *buffer,
> 				 const volatile void __iomem *addr,
> 				 size_t size)
> 
> static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
> 			       size_t size)
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  include/asm-generic/io.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d39ac997dda8..63131ec4857f 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1067,9 +1067,9 @@ static inline void memset_io(volatile void __iomem *addr, int value,
>  #define memcpy_fromio memcpy_fromio
>  /**
>   * memcpy_fromio	Copy a block of data from I/O memory

This needs a dash ('-') between the function name & its description.

> - * @dst:		The (RAM) destination for the copy
> - * @src:		The (I/O memory) source for the data
> - * @count:		The number of bytes to copy
> + * @buffer:		The (RAM) destination for the copy
> + * @addr:		The (I/O memory) source for the data
> + * @size:		The number of bytes to copy
>   *
>   * Copy a block of data from I/O memory.
>   */
> @@ -1085,9 +1085,9 @@ static inline void memcpy_fromio(void *buffer,
>  #define memcpy_toio memcpy_toio
>  /**
>   * memcpy_toio		Copy a block of data into I/O memory

Same here.

> - * @dst:		The (I/O memory) destination for the copy
> - * @src:		The (RAM) source for the data
> - * @count:		The number of bytes to copy
> + * @addr:		The (I/O memory) destination for the copy
> + * @buffer:		The (RAM) source for the data
> + * @size:		The number of bytes to copy
>   *
>   * Copy a block of data to I/O memory.
>   */
> 

If you would fix the above, you can also add:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
