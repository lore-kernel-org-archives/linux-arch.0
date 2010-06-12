From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH v2] sata_sil24: Use memory barriers before issuing
	commands
Date: Fri, 11 Jun 2010 19:30:54 -0600
Message-ID: <AANLkTilxkyOVQU6OjL7ceucxPnbX9qAjWjjM1U16M1Rm@mail.gmail.com>
References: <20100611101117.GD16436@laptop>
	<1276254252.16663.9.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36359 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab0FLBaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2010 21:30:55 -0400
In-Reply-To: <1276254252.16663.9.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nick Piggin <npiggin@suse.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Tuckley <colin.tuckley@arm.com>, Jeff Garzik <jeff@garzik.org>, linux-arch <linux-arch@vger.kernel.org>

On Fri, Jun 11, 2010 at 5:04 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Fri, 2010-06-11 at 11:11 +0100, Nick Piggin wrote:
>> On Fri, Jun 11, 2010 at 10:41:46AM +0100, Catalin Marinas wrote:
>> > On Fri, 2010-06-11 at 02:38 +0100, Nick Piggin wrote:
>> > > On Thu, Jun 10, 2010 at 06:43:03PM -0600, Robert Hancock wrote:
>> > > > IMHO, it would be better for the platform code to ensure that =
MMIO
>> > > > access was strongly ordered with respect to each other and to =
RAM
>> > > > access. Drivers are just too likely to get this wrong, especia=
lly
>> > > > when x86, the most tested platform, doesn't have such issues.
>> > >
>> > > The plan is to make all platforms do this. writes should be
>> > > strongly ordered with memory. That serves to keep them inside
>> > > critical sections as well.
> [...]
>> Also I think most high performance drivers tend to have just a few
>> critical mmios so they should be able to be identified and improved
>> relatively easily (relatively, as in: much =A0more easily than tryin=
g to
>> find all the obscure ordering problems).
>>
>> So anyway powerpc were reluctant because they try to fix it in their
>> spinlocks, but I demonstrated that there were drivers using mutexes
>> and other synchronization and found one or two broken ones in the
>> first place I looked.
>
> On the ARM implementation we are safe with regards to spinlocks/mutex=
es
> vs. IO accesses, no weird ordering issues here (if there would be, I
> agree that it would need fixing).
>
>> > The only reference of DMA buffers vs I/O I found in the DMA-API.tx=
t
>> > file:
>> >
>> > =A0 =A0 =A0 =A0 Consistent memory is memory for which a write by e=
ither the
>> > =A0 =A0 =A0 =A0 device or the processor can immediately be read by=
 the processor
>> > =A0 =A0 =A0 =A0 or device without having to worry about caching ef=
fects. (You
>> > =A0 =A0 =A0 =A0 may however need to make sure to flush the process=
or's write
>> > =A0 =A0 =A0 =A0 buffers before telling devices to read that memory=
=2E)
>> >
>> > But there is no API for "flushing the processor's write buffers". =
Does
>> > it mean that this should be taken care of in writel()? We would ma=
ke the
>> > I/O accessors pretty expensive on some architectures.
>>
>> The APIs for that are mb/wmb/rmb ones.
>
> So if that's the API for the above case and we are strictly referring=
 to
> the sata_sil24 patch I sent - shouldn't we just add wmb() in the driv=
er
> between the write to the DMA buffer and the writel() to start the DMA
> transfer? Do we need to move the wmb() to the writel() macro?

I think it would be best if writel, etc. did the write buffer flushing
by default. As Nick said, if there are some performance critical areas
then those can use the relaxed versions but it's safest if the default
behavior works as drivers expect.
