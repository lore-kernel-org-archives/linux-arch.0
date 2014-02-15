From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 19/73] arm: mach-s3c64xx mach-crag6410-module.c is not
 modular
Date: Sun, 16 Feb 2014 02:04:00 +0900
Message-ID: <52FF9E00.90005@samsung.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-20-git-send-email-paul.gortmaker@windriver.com> <20140123131621.GD11589@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:61805 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbaBOREK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Feb 2014 12:04:10 -0500
In-Reply-To: <20140123131621.GD11589@opensource.wolfsonmicro.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arch@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org

On 01/23/14 22:16, Charles Keepax wrote:
> On Tue, Jan 21, 2014 at 04:22:22PM -0500, Paul Gortmaker wrote:
>> Despite the name mach-crag6410-module.c, the code is built for
>> MACH_WLF_CRAGG_6410 -- which is bool, and hence this code is
>> either present or absent.  It will never be modular, so using
>> module_init as an alias for __initcall can be somewhat
>> misleading.
>>
>> Fix this up now, so that we can relocate module_init from
>> init.h into module.h in the future.  If we don't do this, we'd
>> have to add module.h to obviously non-modular code, and that
>> would be a worse thing.
>>
>> Note that direct use of __initcall is discouraged, vs. one
>> of the priority categorized subgroups.  As __initcall gets
>> mapped onto device_initcall, our use of device_initcall
>> directly in this change means that the runtime impact is
>> zero -- it will remain at level 6 in initcall ordering.
>>
>> Cc: Ben Dooks<ben-linux@fluff.org>
>> Cc: Kukjin Kim<kgene.kim@samsung.com>
>> Cc: Russell King<linux@arm.linux.org.uk>
>> Cc: patches@opensource.wolfsonmicro.com
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Paul Gortmaker<paul.gortmaker@windriver.com>
>> ---
>
> Tested-by: Charles Keepax<ckeepax@opensource.wolfsonmicro.com>
>
Thanks, applied.

- Kukjin
