From: Michal Simek <michal.simek@petalogix.com>
Subject: Re: mmap hw behavior
Date: Thu, 09 Jul 2009 10:57:47 +0200
Message-ID: <4A55B10B.7010200@petalogix.com>
References: <4A54DF6F.1010405@petalogix.com>	<20090708.110624.104984745.davem@davemloft.net>	<4A54FFFE.10306@petalogix.com> <20090708.181551.189345850.davem@davemloft.net>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:45148 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbZGII5z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2009 04:57:55 -0400
In-Reply-To: <20090708.181551.189345850.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, arnd@arndb.de, lethal@linux-sh.org, ltp-list@lists.sourceforge.net

David Miller wrote:
> From: Michal Simek <michal.simek@petalogix.com>
> Date: Wed, 08 Jul 2009 22:22:22 +0200
>
>   
>> Can you please point me to any code which exactly do this? (for example
>> file mm/mmap.c line from ... to ... )
>>     
>
> Sorry I don't have time to read the source code for you.
> I'd have to look it up too, just like you.
>   
I found it - Microblaze hasn't defined tlb_flush macro.

Thanks for your help,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
