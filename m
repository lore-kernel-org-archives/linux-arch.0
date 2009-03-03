Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:34555 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229AbZCCQMl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Mar 2009 11:12:41 -0500
Message-ID: <49AD56F3.6020305@gmail.com>
Date: Tue, 03 Mar 2009 17:12:35 +0100
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic debug pagealloc
References: <20090303160103.GB5812@localhost.localdomain>
In-Reply-To: <20090303160103.GB5812@localhost.localdomain>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org
Message-ID: <20090303161235.88M6ZMwpa6tdTG3vBkQgqYFHfZ3rT-_0xh4xT7ONflw@z>

On 3.3.2009 17:01, Akinobu Mita wrote:
...
> +static void dump_broken_mem(unsigned char *mem)
> +{
> +	int i;
> +	int start = 0;
> +	int end = PAGE_SIZE - 1;
> +
> +	for (i = 0; i<  PAGE_SIZE; i++) {
> +		if (mem[i] != PAGE_POISON) {
> +			start = i;
> +			break;
> +		}
> +	}
> +	for (i = PAGE_SIZE - 1; i>= start; i--) {
> +		if (mem[i] != PAGE_POISON) {
> +			end = i;
> +			break;
> +		}
> +	}
> +	printk(KERN_ERR "Page corruption: %p-%p\n", mem + start, mem + end);
> +	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1, mem + start,
> +			end - start + 1, 1);
> +}
> +
> +static void unpoison_page(struct page *page)
> +{
> +	unsigned char *mem;
> +	int i;
> +
> +	if (!page->poison)
> +		return;
> +
> +	mem = kmap_atomic(page, KM_USER0);
> +	for (i = 0; i<  PAGE_SIZE; i++) {
> +		if (mem[i] != PAGE_POISON) {
> +			dump_broken_mem(mem);

Just an optimisation: pass the i to the dump_broken_mem as a start index.

> +			break;
> +		}
> +	}
> +	kunmap_atomic(mem, KM_USER0);
> +	page->poison = false;
> +}
