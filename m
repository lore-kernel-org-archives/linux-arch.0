Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1660 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752988AbaDXKjn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Apr 2014 06:39:43 -0400
Message-ID: <5358E9EB.8080307@nod.at>
Date: Thu, 24 Apr 2014 12:39:39 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH 17/28] nios2: Signal handling support
References: <1397824031-4892-1-git-send-email-lftan@altera.com>	<1397824031-4892-14-git-send-email-lftan@altera.com>	<CAFLxGvyPCwo-d92QK9qAR5=gmRS4p24tYs9PiOApBGfrKdxJ5Q@mail.gmail.com>	<CAFiDJ5-q5hzR+1BDCmCzwqbuVZOUdjX_-omR4u3rnC8xqdQZLA@mail.gmail.com>	<CAFiDJ59g0E+hoREriydqk2uBsDvchPMSQi6NCgnwOd64OGLJ0w@mail.gmail.com>	<5358E4B9.1050308@nod.at> <CAFiDJ5_pbcQo7VPj6J9UVhxGQtGn7hX19vkybL3DvM73v8Dc-w@mail.gmail.com>
In-Reply-To: <CAFiDJ5_pbcQo7VPj6J9UVhxGQtGn7hX19vkybL3DvM73v8Dc-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
Message-ID: <20140424103939.VE7qJm6OMmepL1Hj4IdGqtmqYOhlHnqBs6Bv5nC9f54@z>

Am 24.04.2014 12:29, schrieb Ley Foon Tan:
> On Thu, Apr 24, 2014 at 6:17 PM, Richard Weinberger <richard@nod.at> wrote:
> 
>>>> Okay.
>>>>
>>> I just noticed that sigsp() have struct ksignal argument. We can use
>>> sigsp() for nios2 because it doesn't have struct ksignal.
>>>
>>> unsigned long sigsp(unsigned long sp, struct ksignal *ksig);
>>
>> Did you at look at the struct ksignal definition and the clean series I've
>> pointed you to?
>>
> 
> Not yet, this is the full set of patches? I only see partial..
> https://lkml.org/lkml/2014/3/2/198

Maybe lkml.org misses a few but this does not matter.
All you need to know is that using ksignal is easy.
e.g. https://lkml.org/lkml/2014/3/2/162

Thanks,
//richard
