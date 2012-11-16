From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC PATCH v1 26/31] ARC: Build system: Makefiles, Kconfig, Linker
 script
Date: Fri, 16 Nov 2012 12:06:02 +0530
Message-ID: <50A5DED2.5030803@synopsys.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-27-git-send-email-vgupta@synopsys.com> <50A52B45.6030907@imgtec.com> <20121115193050.GA1244@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:32921 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2KPGhu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2012 01:37:50 -0500
In-Reply-To: <20121115193050.GA1244@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de, linux-mips@linux-mips.org

On Friday 16 November 2012 01:00 AM, Ralf Baechle wrote:
> On Thu, Nov 15, 2012 at 05:49:57PM +0000, James Hogan wrote:
>
>> On 07/11/12 09:47, Vineet Gupta wrote:
>>> +config ARC
>> I just came across arch/mips/Kconfig which also defines ARC (and ARC32).
>> It's only used within arch/mips/, however it's probably more likely that
>> your ARC/CONFIG_ARC will find it's way into the generic bits of the
>> kernel which could get hit when the other ARC is defined.
>>
>> Perhaps it's worth getting the other ARC renamed just in case?
> The MIPS world surely isn't as attached to the CONFIG_ARC config symbol
> as Synopsis so I'm going to rename CONFIG_ARC and a few other firmware
> related config symbols to use a consistent prefix of CONFIG_FW_.

Thanks Ralf !

-Vineet
>   Ralf
