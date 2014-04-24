From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 17/28] nios2: Signal handling support
Date: Thu, 24 Apr 2014 18:13:58 +0800
Message-ID: <CAFiDJ59g0E+hoREriydqk2uBsDvchPMSQi6NCgnwOd64OGLJ0w@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-14-git-send-email-lftan@altera.com>
	<CAFLxGvyPCwo-d92QK9qAR5=gmRS4p24tYs9PiOApBGfrKdxJ5Q@mail.gmail.com>
	<CAFiDJ5-q5hzR+1BDCmCzwqbuVZOUdjX_-omR4u3rnC8xqdQZLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFiDJ5-q5hzR+1BDCmCzwqbuVZOUdjX_-omR4u3rnC8xqdQZLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 24, 2014 at 6:01 PM, Ley Foon Tan <lftan@altera.com> wrote:
> On Sun, Apr 20, 2014 at 3:29 AM, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>
>>> +
>>> +       /* Default to using normal stack.  */
>>> +       usp = regs->sp;
>>> +
>>> +       /* This is the X/Open sanctioned signal stack switching.  */
>>> +       if ((ka->sa.sa_flags & SA_ONSTACK) && (current->sas_ss_sp != 0)) {
>>> +               if (!on_sig_stack(usp))
>>> +                       usp = current->sas_ss_sp + current->sas_ss_size;
>>> +       }
>>
>> You can use sigsp() here.
> Okay.
>
I just noticed that sigsp() have struct ksignal argument. We can use
sigsp() for nios2 because it doesn't have struct ksignal.

unsigned long sigsp(unsigned long sp, struct ksignal *ksig);
