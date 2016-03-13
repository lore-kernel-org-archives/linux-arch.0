From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Sat, 12 Mar 2016 17:02:33 -0800
Message-ID: <CALCETrWNwt2-1JHTktAL-ppRbLgJ-aY9GDPkrf+46-qbh8aemw@mail.gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
 <20160305114012.GA7259@gmail.com> <1457370228.15454.311.camel@hpe.com>
 <CALCETrUQsf7S-b+zDrof0g61NnSB3XuqdAxjsHyJfjT3D39D3Q@mail.gmail.com> <1457735807.6393.206.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34480 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbcCMBCx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 12 Mar 2016 20:02:53 -0500
Received: by mail-ob0-f175.google.com with SMTP id ts10so146398536obc.1
        for <linux-arch@vger.kernel.org>; Sat, 12 Mar 2016 17:02:53 -0800 (PST)
In-Reply-To: <1457735807.6393.206.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Fri, Mar 11, 2016 at 2:36 PM, Toshi Kani <toshi.kani@hpe.com> wrote:
> On Thu, 2016-03-10 at 22:47 -0800, Andy Lutomirski wrote:
>> On Mon, Mar 7, 2016 at 9:03 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
>> > Let me try to summarize...
>> >
>> > The original issue Luis brought up was that drivers written to work
>> > with MTRR may create a single ioremap range covering multiple cache
>> > attributes since MTRR can overwrite cache attribute of a certain
>> > range.  Converting such drivers with PAT-based ioremap interfaces, i.e.
>> > ioremap_wc() and ioremap_nocache(), requires a separate ioremap map for
>> > each cache attribute, which can be challenging as it may result in
>> > overlapping ioremap ranges (in his term) with different cache
>> > attributes.
>> >
>> > So, Luis asked about 'sematics of overlapping ioremap()' calls.  Hence,
>> > I responded that aliasing mapping itself is supported, but alias with
>> > different cache attribute is not.  We have checks in place to detect
>> > such condition.  Overlapping ioremap calls with a different cache
>> > attribute either fails or gets redirected to the existing cache
>> > attribute on x86.
>>
>> A little off-topic, but someone reminded me recently: most recent CPUs
>> have self-snoop.  It's poorly documented, but on self-snooping CPUs, I
>> think that a lot of the aliasing issues go away.  We may be able to
>> optimize the code quite a bit on these CPUs.
>
> Interesting.  I wonder how much we can rely on this feature.  Yes, by
> looking at Intel SDM, it is indeed poorly documented. :-(

Any Intel people want to give us a hint?

--Andy
