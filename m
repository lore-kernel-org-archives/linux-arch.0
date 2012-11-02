From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn-yOkvZcmFvRU@public.gmane.org>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of function 'iowrite32'
Date: Fri, 02 Nov 2012 11:05:35 +0100
Message-ID: <87liekz5e8.fsf@nemi.mork.no>
References: <20121101130420.GB20982@kroah.com>
	<20121101132342.GE12489@arwen.pp.htv.fi> <87k3u5h296.fsf@nemi.mork.no>
	<20121101.110658.149879582446959580.davem@davemloft.net>
	<20121102091620.GE17938@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121102091620.GE17938-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org> (Felipe Balbi's message
	of "Fri, 2 Nov 2012 11:16:20 +0200")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

=46elipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
> On Thu, Nov 01, 2012 at 11:06:58AM -0400, David Miller wrote:
>> From: Bj=C3=B8rn Mork <bjorn-yOkvZcmFvRU@public.gmane.org>
>> Date: Thu, 01 Nov 2012 14:38:29 +0100
>>=20
>> > Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>> >=20
>> >> btw, only alpha and x86 seem to be providing all of those, but if=
 you
>> >> look into our documentation, it's said that drivers are supposed =
to use
>> >> write/read{b,w,l,q} for all memory-mapped io. I'd expect all plat=
forms
>> >> to provide those even if just to allow compilation of drivers.
>> >=20
>> > Only if HAS_IOMEM is true, I believe.
>>=20
>> This is correct.
>
> fair enough, then we can depend on HAS_IOMEM.
>
> Another question, if HAS_IOMEM is true, is the arch expected to provi=
de
> *all* accessor methods ?

I'll leave this for those with more clue...

But there is a comment in arch/alpha/include/asm/io.h indicating that
writeq/readq support is tested separately, so I guess it must be
optional:

/*
 * Some mucking forons use if[n]def writeq to check if platform has it.
 * It's a bloody bad idea and we probably want ARCH_HAS_WRITEQ for them
 * to play with; for now just use cpp anti-recursion logics and make su=
re
 * that damn thing is defined and expands to itself.
 */

#define writeq writeq
#define readq readq


> And the last one: if the arch provides
> read/write{b,w,l,q}, should it be selecting HAS_IOMEM ??

But that one is easy: HAS_IOMEM is true by default.  The arch sets
NO_IOMEM to disable it. Similar to HAS_DMA.  So you can be pretty sure
that HAS_IOMEM is selected unless the arch has reasons not to.  From
lib/Kconfig:

config HAS_IOMEM
        boolean
        depends on !NO_IOMEM
        select GENERIC_IO
        default y



Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
