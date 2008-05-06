From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 46/56] microblaze_v2: headers files entry.h current.h
 mman.h registers.h sembuf.h
Date: Tue, 06 May 2008 11:07:16 +0200
Message-ID: <48201FC4.9040809@seznam.cz>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <8e1d421649250f7a3f638cd552bc46e5f5845890.1209897267.git.monstr@monstr.eu> <5b1319d426b1f55e08402790b4bc16a33ec7c00c.1209897267.git.monstr@monstr.eu> <200805051154.28761.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:56501 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761537AbYEFJGN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 05:06:13 -0400
In-Reply-To: <200805051154.28761.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

Hi Arnd,

I keep mman.h in this style. I see the best way push microblaze to mainline and
then synchronize all these files together among all archs.

I'll add it to my future list.

M


> On Sunday 04 May 2008, monstr@seznam.cz wrote:
>> +#ifndef _ASM_MICROBLAZE_MMAN_H
>> +#define _ASM_MICROBLAZE_MMAN_H
>> +
>> +#include <asm-generic/mman.h>
>> +
>> +#define MAP_GROWSDOWN  0x0100 /* stack-like segment */
>> +#define MAP_DENYWRITE  0x0800 /* ETXTBSY */
>> +#define MAP_EXECUTABLE 0x1000 /* mark it as an executable */
>> +#define MAP_LOCKED     0x2000 /* pages are locked */
>> +#define MAP_NORESERVE  0x4000 /* don't check for reservations */
>> +#define MAP_POPULATE   0x8000 /* populate (prefault) pagetables */
>> +#define MAP_NONBLOCK   0x10000 /* do not block on IO */
>> +
>> +#define MCL_CURRENT    1 /* lock all current mappings */
>> +#define MCL_FUTURE     2 /* lock all future mappings */
>> +
>> +#endif /* _ASM_MICROBLAZE_MMAN_H */
> 
> I think we should come up with a good way to fold these into the
> asm-generic header, as half the architectures use the same values
> for them, in addition to what is already shared.
> 
> 	Arnd <><
> 
