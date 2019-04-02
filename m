From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 2/4] arm64: compat: Split kuser32
Date: Tue, 2 Apr 2019 10:47:18 +0100
Message-ID: <9cf9bb3c-7183-f01f-7c13-9874aeea1b3f@arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-3-vincenzo.frascino@arm.com>
 <20190401143030.GG14874@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401143030.GG14874@arrakis.emea.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
