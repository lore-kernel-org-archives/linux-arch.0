From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 17/28] nios2: Signal handling support
Date: Thu, 24 Apr 2014 18:46:35 +0800
Message-ID: <CAFiDJ59hHikNKcY8hCu9M=hOQoL9STED82hEhAggubq3jqt3ig@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-14-git-send-email-lftan@altera.com>
	<CAFLxGvyPCwo-d92QK9qAR5=gmRS4p24tYs9PiOApBGfrKdxJ5Q@mail.gmail.com>
	<CAFiDJ5-q5hzR+1BDCmCzwqbuVZOUdjX_-omR4u3rnC8xqdQZLA@mail.gmail.com>
	<CAFiDJ59g0E+hoREriydqk2uBsDvchPMSQi6NCgnwOd64OGLJ0w@mail.gmail.com>
	<5358E4B9.1050308@nod.at>
	<CAFiDJ5_pbcQo7VPj6J9UVhxGQtGn7hX19vkybL3DvM73v8Dc-w@mail.gmail.com>
	<5358E9EB.8080307@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5358E9EB.8080307@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 24, 2014 at 6:39 PM, Richard Weinberger <richard@nod.at> wrote:
> Am 24.04.2014 12:29, schrieb Ley Foon Tan:
>> On Thu, Apr 24, 2014 at 6:17 PM, Richard Weinberger <richard@nod.at> wrote:
>>
>>>>> Okay.
>>>>>
>>>> I just noticed that sigsp() have struct ksignal argument. We can use
>>>> sigsp() for nios2 because it doesn't have struct ksignal.
>>>>
>>>> unsigned long sigsp(unsigned long sp, struct ksignal *ksig);
>>>
>>> Did you at look at the struct ksignal definition and the clean series I've
>>> pointed you to?
>>>
>>
>> Not yet, this is the full set of patches? I only see partial..
>> https://lkml.org/lkml/2014/3/2/198
>
> Maybe lkml.org misses a few but this does not matter.
> All you need to know is that using ksignal is easy.
> e.g. https://lkml.org/lkml/2014/3/2/162
>
Thanks. I am looking at your git tree
https://git.kernel.org/cgit/linux/kernel/git/rw/misc.git/log/?h=signal_v2
Are these patches already available in v3.15 rc?
I can update nios2 to use new implementation.

Regards
Ley Foon
