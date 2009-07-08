From: Michal Simek <michal.simek@petalogix.com>
Subject: Re: mmap hw behavior
Date: Wed, 08 Jul 2009 20:03:27 +0200
Message-ID: <4A54DF6F.1010405@petalogix.com>
References: <4A54D14F.9090101@petalogix.com> <20090708.103520.193697491.davem@davemloft.net>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58518 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbZGHSDc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2009 14:03:32 -0400
In-Reply-To: <20090708.103520.193697491.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, arnd@arndb.de, lethal@linux-sh.org, ltp-list@lists.sourceforge.net

David Miller wrote:
> From: Michal Simek <michal.simek@petalogix.com>
> Date: Wed, 08 Jul 2009 19:03:11 +0200
>
>   
>> When I call mmap for that open file with pointer to calloc place
>> (first parameter, + length zero) it should be one tlb invalidation
>> for calloc and new tlb which connect open file.  We check it and we
>> don't have any tlb invalidation that's why I think that kernel do
>> different thigs.  Or is it there any copying? Or anything different?
>>     
>
> There is no need to tlb flush the calloc area unless that memory area
> is actually touched by the user application and thus the page is
> faulted in.
>   
That calloc area is filled by any value (in that test). Is it mean that
for this case when calloc area is touched
there must be tlb invalidation + remapping?

Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
