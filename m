From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [Linux-Xtensa] [PATCHv2 14/17] xtensa: add MX irqchip
Date: Sun, 1 Dec 2013 12:07:46 +0400
Message-ID: <CAMo8BfLSyAtWO_LbKDBKmxC5_6HJAjsoSJSf5EFbNqAAXz6M+g@mail.gmail.com>
References: <528B0906.6070105@zankel.net>
	<1385876327-26445-1-git-send-email-jcmvbkbc@gmail.com>
	<20131201072001.GF4302@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56866 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3LAIHr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Dec 2013 03:07:47 -0500
Received: by mail-oa0-f46.google.com with SMTP id o6so11769129oag.5
        for <linux-arch@vger.kernel.org>; Sun, 01 Dec 2013 00:07:46 -0800 (PST)
In-Reply-To: <20131201072001.GF4302@tarshish>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Sun, Dec 1, 2013 at 11:20 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Max,
>
> On Sun, Dec 01, 2013 at 09:38:47AM +0400, Max Filippov wrote:
>> MX is an interrupt distributor used in some SMP-capable xtensa
>> configurations.
>>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>
> [...]
>
>> +IRQCHIP_DECLARE(xtensa_mx_irq_chip, "xtensa,mx", xtensa_mx_init);
>
> This should probably better named "cdns,xtensa-mx", according to the ePAPR 1.1
> recommendation.

Right, I've sent an update for both MX and PIC xtensa irqchips.

-- 
Thanks.
-- Max
