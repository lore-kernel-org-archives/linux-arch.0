Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:58956 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753168AbXFYNL4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jun 2007 09:11:56 -0400
In-Reply-To: <1182774873.12109.83.camel@pmac.infradead.org>
References: <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org> <20070625103535.GF22063@parisc-linux.org> <20070625110907.GA23438@flint.arm.linux.org.uk> <1182771454.12109.71.camel@pmac.infradead.org> <20070625114742.GG22063@parisc-linux.org> <2fc3aacccf036072f1b959e7b9ec3629@kernel.crashing.org> <1182774873.12109.83.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <44a862a6e0b8df8765958d456d9b17d6@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on PowerPC and ARM
Date: Mon, 25 Jun 2007 15:10:43 +0200
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@linux-foundation.org, Russell King <rmk@arm.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@linux-foundation.org>, drepper@redhat.com, paulus@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>> I don't see any 64-bit integers here.
>
> Of course not. This is the routine which is called from 32-bit code.
> The prototype in the 32-bit code is (int, unsigned, loff_t, loff_t).

Ah I see, sorry for the confusion.

>>> Also, you might want to put something in the syscall file about 
>>> signed
>>> vs unsigned arguments and how they behave with 32-on-64 systems.
>>
>> "Both work / unsigned is better / use unsigned whenever
>> possible" -- but that's true for all C coding.  Wouldn't
>> hurt to repeat it though :-)
>
> Don't we need (int)(-1) to be represented as 0xFFFFFFFFFFFFFFFF in a
> register in 64-bit code, while we only get 0xFFFFFFFF passed in from
> userspace?

Yes exactly, signed integers need sign extensions, which
makes them less efficient.  Some ABIs need zero extensions
too, but on a whole unsigned works better.  Most of the
time you don't need to do much on the (C code) kernel side
of things.

Is this enough handwaving?  I'm sure someone else can explain
this a lot better than me :-)


Segher

