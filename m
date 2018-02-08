From: Jia He <hejianet@gmail.com>
Subject: Re: [PATCH] ACPI/IORT: Remove linker section for IORT entries again
Date: Thu, 8 Feb 2018 10:37:54 +0800
Message-ID: <c2f09386-90c6-809c-127b-87bd3d80c7ca@gmail.com>
References: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
 <20180207114104.GA22549@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180207114104.GA22549@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-arch.vger.kernel.org



On 2/7/2018 7:41 PM, Lorenzo Pieralisi Wrote:
> On Tue, Feb 06, 2018 at 08:11:34PM -0800, Jia He wrote:
>> In commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
>> probing"), iort entries was removed in vmlinux.lds.h. But in
>> commit 2fcc112af37f ("clocksource/drivers: Rename clksrc table to timer"),
>> this line was back incorrectly.
>>
>> It does no harm except for adding some useless symbols, so fix it.
>>
>> Signed-off-by: Jia He <hejianet@gmail.com>
forget to add another Signed-off-by line(because of my company's 
opensource rules)

Signed-off-by: Jia He <jia.he@hxt-semitech.com>

>> ---
>>   include/asm-generic/vmlinux.lds.h | 1 -
>>   1 file changed, 1 deletion(-)
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> Who is picking this up ?
Sorry, do you mean who is picking up acpi/iort subsystem?
I can't answer this question. I find this minor bug while doing the code 
review.

Cheers,
Jia
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index 1ab0e52..58b1dab 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -589,7 +589,6 @@
>>   	IRQCHIP_OF_MATCH_TABLE()					\
>>   	ACPI_PROBE_TABLE(irqchip)					\
>>   	ACPI_PROBE_TABLE(timer)						\
>> -	ACPI_PROBE_TABLE(iort)						\
>>   	EARLYCON_TABLE()
>>   
>>   #define INIT_TEXT							\
>> -- 
>> 2.7.4
>>
