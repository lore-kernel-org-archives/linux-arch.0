From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Software prefetching considered harmful
Date: Fri, 20 May 2011 17:01:34 +0100
Message-ID: <BANLkTikKSL8=wngi0ZvuRH4YOqe0FmWh2A@mail.gmail.com>
References: <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
	<20110519.153259.1670240855485459381.davem@davemloft.net>
	<BANLkTi=0N55+mQjE1gq8DHdoQ0GU0A7kLw@mail.gmail.com>
	<20110519.154700.1253349185128359804.davem@davemloft.net>
	<20110519233400.GA1954@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60341 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934464Ab1ETQBf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2011 12:01:35 -0400
Received: by iwn34 with SMTP id 34so3136085iwn.19
        for <linux-arch@vger.kernel.org>; Fri, 20 May 2011 09:01:34 -0700 (PDT)
In-Reply-To: <20110519233400.GA1954@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, benh@kernel.crashing.org, rmk@arm.linux.org.uk

On 20 May 2011 00:34, Ingo Molnar <mingo@elte.hu> wrote:
> * David Miller <davem@davemloft.net> wrote:
>
>> So, to reiterate, I think you should kill all the list handling
>> prefetches off.
>
> Agreed.
>
>> What we can do is say "for this specific list use, prefetch does
>> in fact help". =A0And provide an interface for that. =A0I imagine th=
ere
>> are things like inode dirty writeback or some dcache stuff that
>> walks large lists and for which prefetch might be appropriate.
>
> I think the best 'interface' for that is to open-code the prefetch()
> right into the loop. This way it becomes well documented and very
> visible as well.

I talked to some of the CPU people in ARM and, while there are a
variety of ARM implementations, for many of them prefetch(0) would
result in a TLB miss and go for an expensive page table walk. For
mostly 1-element lists like hash table look-up it's not worth having
the prefetch (could make it worse).

Prefetch is indeed useful for traversing longer lists (and probably
more work inside the loop) but I guess we can code the prefetch()
explicitly as Dave and Ingo suggested.

--=20
Catalin
