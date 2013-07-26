From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 11/14] powerpc: Eliminate NO_IRQ usage
Date: Thu, 25 Jul 2013 21:56:14 -0600
Message-ID: <CACxGe6s3wit88ynuzYsBZBvijHmAfJNeY9LH2T5S9iY7kJtg=w@mail.gmail.com>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-12-git-send-email-grant.likely@secretlab.ca> <CAMuHMdV=pSG+CtvGqr1c9nDKeHCU0cVQcFkfAo5iMMna2HOvZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42013 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756302Ab3GZD4f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jul 2013 23:56:35 -0400
Received: by mail-ob0-f172.google.com with SMTP id f8so3327703obp.17
        for <linux-arch@vger.kernel.org>; Thu, 25 Jul 2013 20:56:35 -0700 (PDT)
In-Reply-To: <CAMuHMdV=pSG+CtvGqr1c9nDKeHCU0cVQcFkfAo5iMMna2HOvZg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Thu, Jul 25, 2013 at 3:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Jan 11, 2012 at 9:22 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> NO_IRQ is evil.  Stop using it in arch/powerpc and powerpc device drivers
>
>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> index 3e06696..55c6ff9 100644
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -666,7 +666,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
>>         ssi_private->ssi_phys = res.start;
>>
>>         ssi_private->irq = irq_of_parse_and_map(np, 0);
>> -       if (ssi_private->irq == NO_IRQ) {
>> +       if (!ssi_private->irq) {
>>                 dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
>>                 ret = -ENXIO;
>>                 goto error_iomap;
>
> What's the plan with this patch?
>
> This is now failing on xtensa, as it's one of the architectures that doesn't
> define NO_IRQ. Only arm, c6x, mn10300, openrisc, parisc, powerpc, and sparc
> define it.

Wow. I'd pretty much dropped that patch because I didn't have time to
chase it down. It should be pursued though.

In that particular case it is safe I think to apply the change. PPC
defines NO_IRQ to be 0 anyway.

g.
