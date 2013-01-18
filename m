From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 29/76] ARC: Boot #1: low-level, setup_arch(), /proc/cpuinfo, mem init
Date: Fri, 18 Jan 2013 14:45:38 +0000
Message-ID: <201301181445.39050.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-30-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59403 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3AROpq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:45:46 -0500
In-Reply-To: <1358511930-7424-30-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> +       /* setup bootmem allocator */
> +       bootmap_sz = init_bootmem_node(NODE_DATA(0),
> +                                      first_free_pfn,/* bitmap start */
> +                                      min_low_pfn,   /* First pg to track */
> +                                      max_low_pfn);  /* Last pg to track */
> +
> +       /*
> +        * init_bootmem above marks all tracked Page-frames as inuse "allocated"
> +        * This includes pages occupied by kernel's elf segments.
> +        * Beyond that, excluding bootmem bitmap itself, mark the rest of
> +        * free-mem as "allocatable"
> +        */
> +       alloc_start = kernel_img_end + bootmap_sz;
> +       free_bootmem(alloc_start, end_mem - alloc_start);
> +
> +       memset(zones_size, 0, sizeof(zones_size));
> +       zones_size[ZONE_NORMAL] = num_physpages;
> +

IIRC, the bootmem allocator is no longer recommended for new architecture.
You should use the "memblock" interface instead, as arm64 and tile do.

I just saw that this is still listed as TODO for openrisc, sorry if I
put you on the wrong track there by recommending to copy from openrisc.

	Arnd
