From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v2 12/29] nios2: Interrupt handling
Date: Fri, 18 Jul 2014 14:55:01 +0800
Message-ID: <CAFiDJ5-U-Ce1kX59xEzAe9w8pbah=pZkO15pYNV_YgjQnEPkrw@mail.gmail.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-13-git-send-email-lftan@altera.com>
	<alpine.DEB.2.10.1407151147540.24854@nanos>
	<CAFiDJ58oEfFN5CgLZxqTLSiGfuxNH2t3OFAaSUWLJ_P_B_QRBQ@mail.gmail.com>
	<alpine.DEB.2.10.1407171555580.24854@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1407171555580.24854@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 17, 2014 at 9:58 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 17 Jul 2014, Ley Foon Tan wrote:
>
>> On Tue, Jul 15, 2014 at 5:51 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Tue, 15 Jul 2014, Ley Foon Tan wrote:

>> >> +static void chip_unmask(struct irq_data *d)
>> >> +{
>> >> +     u32 ien;
>> >> +     ien = RDCTL(CTL_IENABLE);
>> >> +     ien |= (1 << d->hwirq);
>> >> +     WRCTL(CTL_IENABLE, ien);
>> >
>> > So this is UP only, right?
>> Yes, this is to enable one interrupt.
>
> The question was, whether this is always a UniProcessor machine.
Yes, it is UP.
>
>> > Also why don't you cache the register content so spare the extra read
>> > from the hardware?
>> Need to make sure nobody modify the register if we cache the register content.
>> Will keep as it is.
>
> Sigh.
>
> If this is a uniprocessor only design, then nothing can modify the
> cached values as all these functions are always called with interrupts
> disabled.
>
> If this should be SMP safe, then you'd need serialization of the
> register access as well becasue the read/modify/write sequence is not
> atomic.
Okay, we can cache the value.
Thanks.

Regards
Ley Foon
