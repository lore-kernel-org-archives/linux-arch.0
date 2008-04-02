Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from yergi.telenet-ops.be ([195.130.132.36]:60201 "EHLO
	yergi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760881AbYDBHR1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Apr 2008 03:17:27 -0400
Received: from edna.telenet-ops.be (unknown [195.130.132.58])
	by yergi.telenet-ops.be (Postfix) with ESMTP id A19A35C9C8C
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2008 09:17:35 +0200 (CEST)
Date: Wed, 2 Apr 2008 09:16:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: max_pfn: Uninitialized, or Deprecated?
In-Reply-To: <47F1F349.7010503@mips.com>
Message-ID: <Pine.LNX.4.64.0804020910290.14383@anakin>
References: <47F1F349.7010503@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20080402071652.SMR1H9msJwMbZWsdmBoP2GzlEux_4rD-E2AEm4BSu9k@z>

On Tue, 1 Apr 2008, Kevin D. Kissell wrote:
> Once upon a time, the global max_pfn value was set up as part of
> bootmem_init(), but this seems to have been dropped in favor of
> establishing max_low_pfn, I suppose to be clear that it's the max
> non-highmem PFN.  However, the global max_pfn gets used in
> the MIPS APRP support code,  and also in places like
> block/blk-settings.c.  Is the use of max_pfn supposed to be
> deprecated, such that we consider blk-settings.c to be broken
> and change arch/mips/kernel/vpe.c to use max_low_pfn, or
> ought we assign  max_pfn = max_low_pfn in bootmem_init()?

I noticed this too when investigating why initrds no longer worked on
m68k (Fix in http://lkml.org/lkml/2007/12/23/36, still not in mainline).

Apparently a value of max_pfn = 0 is OK, as several architectures
(including MIPS and m68k) don't touch it?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
