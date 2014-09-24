From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
Date: Wed, 24 Sep 2014 18:57:54 +0800
Message-ID: <CAFiDJ5-bo_WOz6JockX_BaX0_O0D=+8PjKx7gys-ySKA2KMOaw@mail.gmail.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com>
	<13000968.l0laEvMsix@wuerfel>
	<CAFiDJ582-Bb2=s+AGsAeTHJMwBkUCUEoEbP770MJgTDkvev0yg@mail.gmail.com>
	<12538756.JybTPMqFHj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:49430 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaIXK54 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Sep 2014 06:57:56 -0400
In-Reply-To: <12538756.JybTPMqFHj@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>

On Wed, Sep 24, 2014 at 6:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 24 September 2014 18:18:50 Ley Foon Tan wrote:
>> On Tue, Sep 23, 2014 at 6:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 23 September 2014 18:20:08 LF.Tan wrote:
>> >> Hi Arnd
>> >>
>> >> Are you okay with this generic futex in asm-generic?
>> >>
>> >
>> > Yes, this looks good. Remind me again who need this, would it make
>> > sense to merge this through an architecture-specific tree for
>> > whichever architecture can benefit from it?
>> What is the common practice for this?
>> Do you mean merge with nios2 or other arch, eg m68k?
>
> I mean do it as part of the nios2 patches.
I am okay with this.
Do I need to get ACK for all patches in order for nios2 merge into mainline?
Thanks.

Regards
Ley Foon
