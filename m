From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/22] arm: introduce little endian bitops
Date: Mon, 18 Oct 2010 16:45:12 +0200
Message-ID: <201010181645.13349.arnd@arndb.de>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com> <AANLkTi=1w9uV81CagrE53xEYkMaFh_3cM_+ybctT2ng4@mail.gmail.com> <20101018135616.GB12449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49707 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab0JROpV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2010 10:45:21 -0400
In-Reply-To: <20101018135616.GB12449@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

On Monday 18 October 2010, Russell King - ARM Linux wrote:
> le.h provides:
> 
>         generic___set_le_bit
>         generic___test_and_set_le_bit
>         ...
> 
> Your new patches provide:
> 
>         __set_le_bit
>         __test_and_set_le_bit
> 
> Would it not be better to have le.h provide one set of these LE bitops
> (called either generic___set_le_bit or __set_le_bit - which ever you
> prefer), and then have everyone using those common names (including
> minix-le.h and ext2-non-atomic.h) rather than adding a whole series of
> new bitop macros to the current mess?

One optimization I can think of for the ARM headers would be to only
define find_first_zero_le_bit, find_next_zero_le_bit and find_next_le_bit
in arch/arm/include/asm/bitops.h and take the other definitions from
asm-generic/bitops/le.h, which encloses then duplicate ones in #ifdef.

> To put it another way, if we're providing a set of guaranteed-little-endian
> bitops, I'd like to see ARM doing this:
> 
> #define __test_and_set_le_bit(nr,p) ...
> 
> #include <asm-generic/bitops/minix-le.h>
> #include <asm-generic/bitops/ext2-non-atomic.h>
> 
> where ext2-non-atomic.h could just be:
> 
> #define ext2_set_bit(nr,addr) __test_and_set_le_bit((nr),(unsigned long *)(addr))

Note that patches 20 and 22 of the series completely eliminate the
the minix and ext2 definitions, putting them into architecture independent
code in those two file systems where they belong.

Adding the new definitions in patch 4 is just a logical step before removing
the old definitions in the later patches while maintaining bisectability.

> What I'm trying to say is please don't make the existing mess of bitops
> any worse than it currently is.

The series currently adds 20 lines to the arm code (could be reduced to
6 lines), but removes 26 lines which are essentially architecture
independent and shouldn't be there to start with. I'd call that the
opposite of making the mess worse.

	Arnd
