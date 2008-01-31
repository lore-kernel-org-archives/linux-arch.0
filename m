Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:48565 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbYAaRja (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 31 Jan 2008 12:39:30 -0500
Message-ID: <47A207C3.5050008@goop.org>
Date: Thu, 31 Jan 2008 09:39:15 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: asm-generic/tlb.h and check_pgt_cache()
References: <20080131125425.7e91b54d@dhcp-252-066.norway.atmel.com> <20080131130328.GA29209@cs181133002.pp.htv.fi> <47A1F7C5.3020108@goop.org> <20080131165308.GF19700@cs181133002.pp.htv.fi>
In-Reply-To: <20080131165308.GF19700@cs181133002.pp.htv.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, David Brownell <david-b@pacbell.net>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>

Adrian Bunk wrote:
> <--  snip  -->
>
> ...
>   CC      mm/nommu.o
> In file included from include2/asm/tlb.h:14,
>                  from 
> /home/bunk/linux/kernel-2.6/git/linux-2.6/mm/nommu.c:33:
> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/asm-generic/tlb.h: In function 'tlb_finish_mmu':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/asm-generic/tlb.h:91: error: implicit declaration of function 'check_pgt_cache'
> make[2]: *** [mm/nommu.o] Error 1
>
> <--  snip  -->
>
>   

Right, OK.  Well, I think Ingo reverted my header manipulations, so it 
should all be back to normal.

    J
