From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] asm-generic: Update kernel documentation in io.h
Date: Thu, 14 May 2020 10:31:03 -0700
Message-ID: <a9e29e70-b0c9-9d54-bf87-31d5dcd211ab@infradead.org>
References: <20200514170818.24598-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726027AbgENRbJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 May 2020 13:31:09 -0400
In-Reply-To: <20200514170818.24598-1-miquel.raynal@bootlin.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>

On 5/14/20 10:08 AM, Miquel Raynal wrote:
> The kernel documentation of:
> * bus_to_virt()
> * memcpy_fromio()
> * memcpy_toio()
> refers to older parameters.
> 
> Update it to fit the actual names.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/asm-generic/io.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d39ac997dda8..cb617baf8d47 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1051,8 +1051,8 @@ static inline void *bus_to_virt(unsigned long address)
>  /**
>   * memset_io	Set a range of I/O memory to a constant value
>   * @addr:	The beginning of the I/O-memory range to set
> - * @val:	The value to set the memory to
> - * @count:	The number of bytes to set
> + * @value:	The value to set the memory to
> + * @size:	The number of bytes to set
>   *
>   * Set a range of I/O memory to a given value.
>   */
> @@ -1067,9 +1067,9 @@ static inline void memset_io(volatile void __iomem *addr, int value,
>  #define memcpy_fromio memcpy_fromio
>  /**
>   * memcpy_fromio	Copy a block of data from I/O memory
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

https://lore.kernel.org/lkml/20200424020831.30494-1-wenhu.wang@vivo.com/
is a better (more complete) patch IMO.

if Arnd would merge...

thanks.
-- 
~Randy
