Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:43502 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbcEYV2Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2016 17:28:25 -0400
Date: Wed, 25 May 2016 14:28:21 -0700 (PDT)
Message-ID: <20160525.142821.1719403997976778673.davem@davemloft.net>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
From: David Miller <davem@davemloft.net>
In-Reply-To: <6407614.fdv5XFSBue@wuerfel>
References: <6293194.tGy03QJ9ME@wuerfel>
	<20160525.135039.244098606649448826.davem@davemloft.net>
	<6407614.fdv5XFSBue@wuerfel>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: ynorov@caviumnetworks.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
Message-ID: <20160525212821.3sI6m-_GJUbhahRtxgEru45sgolSL5Zb_cnKO7fNJOU@z>

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 May 2016 23:01:06 +0200

> On Wednesday, May 25, 2016 1:50:39 PM CEST David Miller wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Wed, 25 May 2016 22:47:33 +0200
>> 
>> > If we use the normal calling conventions, we could remove these overrides
>> > along with the respective special-case handling in glibc. None of them
>> > look particularly performance-sensitive, but I could be wrong there.
>> 
>> You could set the lowest bit in the system call entry pointer to indicate
>> the upper-half clears should be elided.
> 
> Right, but that would introduce an extra conditional branch in the syscall
> hotpath, and likely eliminate the gains from passing the loff_t arguments
> in a single register instead of a pair.

Ok, then, how much are you really gaining from avoiding a 'shift' and
an 'or' to build the full 64-bit value?  3 cycles?  Maybe 4?

And the executing the wrappers, those have a non-trivial cost too.

Cost wise, this seems like it all cancels out in the end, but what
do I know?



