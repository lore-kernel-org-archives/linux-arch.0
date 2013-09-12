From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2] xtensa: define NO_IRQ as 0, remove other definitions
Date: Thu, 12 Sep 2013 11:43:07 +0400
Message-ID: <CAMo8Bf+_9pqL+2C-BU5e4S9-jkGNbA-cXu_Rc_V8TcEb_n+BgQ@mail.gmail.com>
References: <1378970254-29094-1-git-send-email-jcmvbkbc@gmail.com>
	<CAMuHMdVko5v2vma+spq_XhzaESVNOT5PdBgmEgFZQhRXamNhmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45719 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab3ILHnH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2013 03:43:07 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so431618iej.34
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2013 00:43:07 -0700 (PDT)
In-Reply-To: <CAMuHMdVko5v2vma+spq_XhzaESVNOT5PdBgmEgFZQhRXamNhmw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, Baruch Siach <baruch@tkos.co.il>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Thu, Sep 12, 2013 at 11:26 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Sep 12, 2013 at 9:17 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>>
>> sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
>> sound/soc/fsl/fsl_ssi.c:939:26: error: 'NO_IRQ' undeclared (first use in this function)
>>
>> Previous definitions (-1) were correct when used as a hardware IRQ number,
>> but are incorrect as a mapped IRQ number.
>>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>>  arch/xtensa/include/asm/irq.h                      |    4 ++++
>>  .../platforms/xtfpga/include/platform/hardware.h   |    4 ----
>>  arch/xtensa/variants/s6000/include/variant/irq.h   |    1 -
>>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> Shouldn't sound/soc/fsl/fsl_ssi.c be changed instead:
>
> -if (ssi_private->irq == NO_IRQ) {
> +if (!ssi_private->irq) {

I agree, this needs to be fixed too.

> Cfr. the thread https://lkml.org/lkml/2013/7/25/642

I saw that thread and I don't see that patch applied anywhere.

Thanks.
-- Max
