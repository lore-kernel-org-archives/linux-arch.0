From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [Linux-Xtensa] [PATCH] xtensa: move NO_IRQ definition into asm/irq.h
Date: Thu, 12 Sep 2013 09:37:53 +0400
Message-ID: <CAMo8BfLbTZwfQw+HVuOJ_6mUfRXoEot5ZDQh6os44dNBwFbK8g@mail.gmail.com>
References: <1378962366-26818-1-git-send-email-jcmvbkbc@gmail.com>
	<20130912051552.GZ4644@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:55844 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab3ILFhx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2013 01:37:53 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so11204008ieb.9
        for <linux-arch@vger.kernel.org>; Wed, 11 Sep 2013 22:37:53 -0700 (PDT)
In-Reply-To: <20130912051552.GZ4644@tarshish>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Chris Zankel <chris@zankel.net>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Thu, Sep 12, 2013 at 9:15 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Max,
>
> On Thu, Sep 12, 2013 at 09:06:06AM +0400, Max Filippov wrote:
>> This fixes the following allmodconfig build error:
>>
>> sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
>> sound/soc/fsl/fsl_ssi.c:939:26: error: 'NO_IRQ' undeclared (first use in this function)
>
> The fsl_ssi driver is buggy here. irq_of_parse_and_map() returns 0 on error,
> not NO_IRQ. Also, see http://lwn.net/Articles/470820/.

Ok, I'll post another one with NO_IRQ defined as 0 in order to allow building
allmodconfig.

-- 
Thanks.
-- Max
