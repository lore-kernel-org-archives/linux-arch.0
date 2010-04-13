From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -v12 00/39] use lmb with x86
Date: Tue, 13 Apr 2010 13:41:44 +1000
Message-ID: <1271130104.13059.37.camel@pasglop>
References: <1270793048-23796-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47397 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab0DMDnc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Apr 2010 23:43:32 -0400
In-Reply-To: <1270793048-23796-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 2010-04-08 at 23:03 -0700, Yinghai Lu wrote:
> the new lmb could be used to early_res in x86.
> 
> Suggested by: David, Ben, and Thomas

I still find most of your changeset comments to be very very poor, if
comprehensible at all. You really MUST make an effort there.

Cheers,
Ben.

> -v6: change sequence as requested by Thomas
> -v7: seperate them to more patches
> -v8: add boundary checking to make sure not free partial page.
> -v9: use lmb_debug to control print out of reserve_lmb.
>      add e820 clean up, and e820 become __initdata
> -v10:use lmb.rmo_size and ARCH_DISCARD_LMB according to Michael
>      change name to lmb_find_area/reserve_lmb_area/free_lmb_area,
>       according to Michael
>      update find_lmb_area to use __lmb_alloc_base according to ben
> -v11:move find_lmb_area_size back to x86.
>      x86 has own find_lmb_area, and could be disabled by ARCH_LMB_FIND_AREA
>       because _lmb_find_base has different behavoir from x86's old one.
>       one from high to high and one from low to high
>       need more test
>      tested for x86 32bit/64bit, numa/nonuma, nobootmem/bootmem.
> -v12:refresh the series with current tip
>      seperate nobootmem.c, so could remove some #ifdef
>      still keep CONFIG_NO_BOOTMEM, in x86 .c, and could use the as tags
>      so other lmb could refer them to use NO_BOOTMEM.
> 
> still keep find_lmb_area, may replace those find_lmb_area will lmb_alloc, if
> everything go fine
> 
> Please put them into tip and -next to have more test coverage.
> 
> Thanks
> 
> Yinghai
