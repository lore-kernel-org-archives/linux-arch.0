From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 07/60] microblaze_v4: Support for semaphores
Date: Thu, 26 Jun 2008 21:27:46 +0200
Message-ID: <4863EDB2.2040701@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	<1214483429-32360-2-git-send-email-monstr@seznam.cz>	<1214483429-32360-3-git-send-email-monstr@seznam.cz>	<1214483429-32360-4-git-send-email-monstr@seznam.cz>	<1214483429-32360-5-git-send-email-monstr@seznam.cz>	<1214483429-32360-6-git-send-email-monstr@seznam.cz>	<1214483429-32360-7-git-send-email-monstr@seznam.cz>	<1214483429-32360-8-git-send-email-monstr@seznam.cz> <20080626143652.GD30954@cs181140183.pp.htv.fi>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:32937 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbYFZT07 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2008 15:26:59 -0400
In-Reply-To: <20080626143652.GD30954@cs181140183.pp.htv.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, drepper@redhat.com, linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com, john.williams@petalogix.com

OK. I'do it.

M

> On Thu, Jun 26, 2008 at 02:29:36PM +0200, monstr@seznam.cz wrote:
>> From: Michal Simek <monstr@monstr.eu>
>>
>>
>> Signed-off-by: Michal Simek <monstr@monstr.eu>
>> ---
>>  include/asm-microblaze/semaphore.h |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>  create mode 100644 include/asm-microblaze/semaphore.h
>>
>> diff --git a/include/asm-microblaze/semaphore.h b/include/asm-microblaze/semaphore.h
>> new file mode 100644
>> index 0000000..d9b2034
>> --- /dev/null
>> +++ b/include/asm-microblaze/semaphore.h
>> @@ -0,0 +1 @@
>> +#include <linux/semaphore.h>
> 
> In -next all asm/semaphore.h headers gained a
>   #warning Use linux/semaphore.h, not asm/semaphore.h
> and the number of asm/semaphore.h is approaching zero.
> 
> You can simply drop this patch.
> 
> cu
> Adrian
> 
> 
> 
> ------------------------------------------------------------------------
> 
> 
> No virus found in this incoming message.
> Checked by AVG. 
> Version: 8.0.101 / Virus Database: 270.4.1/1519 - Release Date: 25.6.2008 04:13
