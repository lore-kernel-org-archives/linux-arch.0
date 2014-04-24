From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 17/28] nios2: Signal handling support
Date: Thu, 24 Apr 2014 12:17:29 +0200
Message-ID: <5358E4B9.1050308@nod.at>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>	<1397824031-4892-14-git-send-email-lftan@altera.com>	<CAFLxGvyPCwo-d92QK9qAR5=gmRS4p24tYs9PiOApBGfrKdxJ5Q@mail.gmail.com>	<CAFiDJ5-q5hzR+1BDCmCzwqbuVZOUdjX_-omR4u3rnC8xqdQZLA@mail.gmail.com> <CAFiDJ59g0E+hoREriydqk2uBsDvchPMSQi6NCgnwOd64OGLJ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFiDJ59g0E+hoREriydqk2uBsDvchPMSQi6NCgnwOd64OGLJ0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Am 24.04.2014 12:13, schrieb Ley Foon Tan:
> On Thu, Apr 24, 2014 at 6:01 PM, Ley Foon Tan <lftan@altera.com> wrote:
>> On Sun, Apr 20, 2014 at 3:29 AM, Richard Weinberger
>> <richard.weinberger@gmail.com> wrote:
>>
>>>> +
>>>> +       /* Default to using normal stack.  */
>>>> +       usp = regs->sp;
>>>> +
>>>> +       /* This is the X/Open sanctioned signal stack switching.  */
>>>> +       if ((ka->sa.sa_flags & SA_ONSTACK) && (current->sas_ss_sp != 0)) {
>>>> +               if (!on_sig_stack(usp))
>>>> +                       usp = current->sas_ss_sp + current->sas_ss_size;
>>>> +       }
>>>
>>> You can use sigsp() here.
>> Okay.
>>
> I just noticed that sigsp() have struct ksignal argument. We can use
> sigsp() for nios2 because it doesn't have struct ksignal.
> 
> unsigned long sigsp(unsigned long sp, struct ksignal *ksig);

Did you at look at the struct ksignal definition and the clean series I've
pointed you to?

Thanks,
//richard
