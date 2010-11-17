Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37556 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab0KQEU7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Nov 2010 23:20:59 -0500
MIME-Version: 1.0
In-Reply-To: <1289966843.26343.359.camel@calx>
References: <AANLkTinop4_JT4JLtdmWkydPgDDU=TyZNbtiBbgeh1dj@mail.gmail.com>
	<1289966843.26343.359.camel@calx>
Date: Tue, 16 Nov 2010 23:20:59 -0500
Message-ID: <AANLkTimrR7DEsgtG=+fJzvdaiKQA-kj8KWU5i2qDWK8Q@mail.gmail.com>
Subject: Re: Behavior of BUG() [Was: Re: [PATCH 2/5] of/fdt: add kernel
 command line option for dtb_compat string]
From: Arnaud Lacombe <lacombar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, dirk.brandewie@gmail.com, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20101117042059.3PkeBXWkTmsDkprGUqiu3J4NwASeuivenk7H5ZhUjQU@z>

Hi,

On Tue, Nov 16, 2010 at 11:07 PM, Matt Mackall <mpm@selenic.com> wrote:
> On Tue, 2010-11-16 at 22:45 -0500, Arnaud Lacombe wrote:
>> Hi,
>>
>> [CC: list reduced as starting a new thread, most on the context
>> removed as this concern a different issue.]
>>
>> On Tue, Nov 16, 2010 at 7:16 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> > On Tue, Nov 16, 2010 at 3:41 PM,  <dirk.brandewie@gmail.com> wrote:
>> >> From: Dirk Brandewie <dirk.brandewie@gmail.com>
>> >> [...]
>> > The kernel needs to complain *loudly* if this occurs because it
>> > represents a bug.  I'm tempted to say use BUG, but that would halt the
>> > kernel and prevent any possibility of kernel log output.
>> > [...]
>> does it ? if CONFIG_BUG is not enabled and the arch has no define for
>> it, the default does _nothing_:
>
> That's because CONFIG_BUG=N is intended for machines where logging is
> irrelevant/impossible.
>
Yes, but it is still a no-op, where the original programmer made it
clear he did not want the kernel to go further.

> You are encouraged to ignore all options under
> CONFIG_EMBEDDED when trying to have a sensible discussion.
>
Unless it creates a situation where it does the opposite of what the
intended behavior, I would guess.

 - Arnaud
