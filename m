From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v3 1/7] m68knommu: fix build error due to the lack of find_next_bit_le()
Date: Tue, 3 May 2011 17:11:20 +0800
Message-ID: <BANLkTi=CmYOisOqMejU2qVGnB4c6Z7yHsA@mail.gmail.com>
References: <1303910411-15793-1-git-send-email-akinobu.mita@gmail.com>
	<1303910411-15793-2-git-send-email-akinobu.mita@gmail.com>
	<4DBFA78F.9060001@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48549 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab1ECJLV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2011 05:11:21 -0400
In-Reply-To: <4DBFA78F.9060001@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, Greg Ungerer <gerg@uclinux.org>, geert@linux-m68k.org

2011/5/3, Greg Ungerer <gerg@snapgear.com>:
> Hi Akinobu,
>
> On 27/04/11 23:20, Akinobu Mita wrote:
>> m68knommu can't build ext4, udf, and ocfs2 due to the lack of
>> find_next_bit_le().
>>
>> This implements find_next_bit_le() on m68knommu by duplicating the
>> generic find_next_bit_le() in lib/find_next_bit.c.
>
> Wouldn't the m68k specific implementation of this in
> arch/m68k/include/asm/bitops_mm.h be better?

find_next_bit_le() in bitops_mm.h has a bug
(Please see https://lkml.org/lkml/2011/4/3/43) and it is not fixed
in mainline yet. So I decided to use generic one for the safety.
