Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56313 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab3KLNre (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2013 08:47:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/11] Add generic fixmap.h
Date: Tue, 12 Nov 2013 14:46:40 +0100
References: <1384262545-20875-1-git-send-email-msalter@redhat.com> <1384262545-20875-2-git-send-email-msalter@redhat.com>
In-Reply-To: <1384262545-20875-2-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201311121446.40700.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20131112134640.ZY37y1kDE9OnvMLn2CyY64WetpqXGfFouMHP4qLPQKQ@z>

On Tuesday 12 November 2013, Mark Salter wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.h
> which is intended to be included from arch/*/include/asm/fixmap.h.


Good idea, 

Acked-by: Arnd Bergmann <arnd@arndb.de>

On Tuesday 12 November 2013, Mark Salter wrote:
> +static __always_inline unsigned long fix_to_virt(const unsigned int idx)
> +{
> +       /*
> +        * this branch gets completely eliminated after inlining,
> +        * except when someone tries to use fixaddr indices in an
> +        * illegal way. (such as mixing up address types or using
> +        * out-of-range indices).
> +        *
> +        * If it doesn't get removed, the linker will complain
> +        * loudly with a reasonably clear error message..
> +        */
> +       if (idx >= __end_of_fixed_addresses)
> +               __this_fixmap_does_not_exist();
> +

You might be able to turn this into the more readable BUILD_BUG_ON().

	Arnd
