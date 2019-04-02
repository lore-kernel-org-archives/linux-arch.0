Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBJrX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 05:47:23 -0400
Subject: Re: [PATCH 2/4] arm64: compat: Split kuser32
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-3-vincenzo.frascino@arm.com>
 <20190401143030.GG14874@arrakis.emea.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9cf9bb3c-7183-f01f-7c13-9874aeea1b3f@arm.com>
Date: Tue, 2 Apr 2019 10:47:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190401143030.GG14874@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190402094718.quePIVC6HCixrK6Ilq8VX1RCOtliDe9OxbiXO1Lrl-Y@z>

On 01/04/2019 15:30, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 12:20:23PM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
>> index 997e6b27ff6a..f19e2b015097 100644
>> --- a/arch/arm64/kernel/kuser32.S
>> +++ b/arch/arm64/kernel/kuser32.S
>> @@ -1,24 +1,9 @@
>>  /*
>> - * Low-level user helpers placed in the vectors page for AArch32.
>> + * AArch32 user helpers.
>>   * Based on the kuser helpers in arch/arm/kernel/entry-armv.S.
>>   *
>>   * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
>> - * Copyright (C) 2012 ARM Ltd.
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> - *
>> - *
>> - * AArch32 user helpers.
>> + * Copyright (C) 2012-2018 ARM Ltd.
> 
> If you remove the license text, please add the SPDX header.
> 

Oops... I will fix it in v2.

-- 
Regards,
Vincenzo
