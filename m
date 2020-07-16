From: Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH] linux: arm: vdso: nullpatch vdso_clock_gettime64 for
 non-virtual timers
Date: Fri, 17 Jul 2020 01:25:53 +0200
Message-ID: <2c4484bf-a127-6f07-75f2-e0f0a15fe257@gmail.com>
References: <20200716150723.9389-1-knaerzche@gmail.com>
 <ac44a5a3-ca35-cd0a-f823-4b814c01c498@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGPXZ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 19:25:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A2C061755
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 16:25:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so9010223wrs.0
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 16:25:58 -0700 (PDT)
In-Reply-To: <ac44a5a3-ca35-cd0a-f823-4b814c01c498@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Vlastimil Babka <vbabka@suse.cz>

Hi Robin,

Am 16.07.20 um 20:46 schrieb Robin Murphy:
> Hi Alex,
>
> On 2020-07-16 16:07, Alex Bee wrote:
>> Along with commit commit 74d06efb9c2f ("ARM: 8932/1: Add clock_gettime64
>> entry point") clock_gettime64 was added for ARM platform to solve the
>> y2k38 problem on 32-bit platforms. glibc from version 2.31 onwards
>> started using this vdso-call on ARM platforms.
>> However it was (probably) forgotten to "nullpatch" this call, when no
>> reliable timer source is available, for example when
>> "arm,cpu-registers-not-fw-configured" is defined in devicetree for
>> "arm,armv7-timer".
>> This results in erratic time jumps whenever "gettimeofday" gets called,
>> since the (non-working) vdso-call will be used instead of a syscall.
>>
>> This patch adds clock_gettime64 to get nullpatched as well. It has been
>> verified to work and solve this issue on Rockchip RK322x, RK3288 and
>> RPi4 (32-bit kernel build) platforms.
>
> FYI, a version of this patch was already submitted, and is just 
> waiting for Russell to apply it:
>
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8987/1
>
> Robin.
OK - couldn't find this before. You can drop my patch than.
>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   arch/arm/kernel/vdso.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
>> index 6bfdca4769a7..fddd08a6e063 100644
>> --- a/arch/arm/kernel/vdso.c
>> +++ b/arch/arm/kernel/vdso.c
>> @@ -184,6 +184,7 @@ static void __init patch_vdso(void *ehdr)
>>       if (!cntvct_ok) {
>>           vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
>>           vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
>> +        vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
>>       }
>>   }
>>
Regards,

Alex
