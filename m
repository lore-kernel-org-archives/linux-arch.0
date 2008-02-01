Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:47394 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909AbYBAAbw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 31 Jan 2008 19:31:52 -0500
Message-ID: <47A2685B.2020101@goop.org>
Date: Thu, 31 Jan 2008 16:31:23 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: asm-generic/tlb.h and check_pgt_cache()
References: <20080131125425.7e91b54d@dhcp-252-066.norway.atmel.com> <20080131130328.GA29209@cs181133002.pp.htv.fi> <47A1F7C5.3020108@goop.org> <20080201000917.GD16399@linux-sh.org>
In-Reply-To: <20080201000917.GD16399@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Adrian Bunk <bunk@kernel.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, David Brownell <david-b@pacbell.net>, Jeff Dike <jdike@addtoit.com>

Paul Mundt wrote:
> Yes, sh has the __pte_free_tlb() wrapping to tlb_remove_page(), but there
> is nothing directly in asm/pgalloc.h that depends on __pte_free_tlb(), so
> maybe the easiest solution is to just have asm/pgalloc.h included by
> asm/tlb.h for the check_pgt_cache() def and move __pte_free_tlb() in to
> asm/tlb.h directly. One could argue that the __x_free_tlb() routines make
> more sense in asm/tlb.h just in terms of namespace anyways.
>
> It's a bit ugly, but if sh is the odd one out here I can live with it.
> This seems to work out ok at least..
>   

x86.git is fixed, so don't worry about it.

    J
