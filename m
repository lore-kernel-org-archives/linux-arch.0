Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pip23.gyao.ne.jp ([125.63.38.249]:52025 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755006AbYAaMsb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 31 Jan 2008 07:48:31 -0500
Date: Thu, 31 Jan 2008 21:18:42 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: asm-generic/tlb.h and check_pgt_cache()
Message-ID: <20080131121842.GA15834@linux-sh.org>
References: <20080131125425.7e91b54d@dhcp-252-066.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080131125425.7e91b54d@dhcp-252-066.norway.atmel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jeremy Fitzhardinge <jeremy@goop.org>, David Brownell <david-b@pacbell.net>

On Thu, Jan 31, 2008 at 12:54:25PM +0100, Haavard Skinnemoen wrote:
> Another way to fix it would be to include asm/pgalloc.h elsewhere, e.g.
> from asm/tlb.h right before including asm-generic/tlb.h. Or perhaps we
> should move check_pgt_cache() into asm/tlb.h on all architectures and
> include asm/pgalloc.h as needed?
> 
> I don't know how many architectures are currently broken -- if it's
> only avr32, I can probably come up with a way to fix it on my own. But
> if there are others, I thought it might be a good idea to coordinate
> things.
> 
sh broke also, and simply moving the check_pgt_cache() definition wasn't
really a sane option due to the quicklist dependence, as you noted. Some
folks seem to have just done check_pgt_cache() in asm/tlb.h (ie, FR-V), I
opted to just include pgalloc.h from tlb.h. Though if this gets fixed
another way, that's fine too.
