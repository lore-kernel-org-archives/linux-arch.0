From: Andy Grover <andy.grover@oracle.com>
Subject: Re: [PATCH 4/5] rds: stop including asm-generic/bitops/le.h directly
Date: Fri, 08 Oct 2010 11:55:55 -0700
Message-ID: <4CAF693B.9030706@oracle.com>
References: <1286532193-29814-1-git-send-email-akinobu.mita@gmail.com> <1286532193-29814-4-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:37019 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab0JHS4Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2010 14:56:16 -0400
In-Reply-To: <1286532193-29814-4-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, rds-devel@oss.oracle.com, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org

On 10/08/2010 03:03 AM, Akinobu Mita wrote:
> asm-generic/bitops/le.h is only intended to be included directly from
> asm-generic/bitops/ext2-non-atomic.h or asm-generic/bitops/minix-le.h
> which implements generic ext2 or minix bit operations.
>
> This stops including asm-generic/bitops/le.h directly and use ext2
> non-atomic bit operations instead.
>
> An alternative approach is introducing little endian bit operations
> in linux/bitops.h. But it needs to touch more files than this change does.

> -	generic___set_le_bit(off, (void *)map->m_page_addrs[i]);
> +	ext2_set_bit(off, (void *)map->m_page_addrs[i]);

I'd like a solution that doesn't have rds calling a function starting 
with ext2_. Seems wrong.

Thanks -- Regards -- Andy
