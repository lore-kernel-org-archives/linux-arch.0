From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: kbuild - introduce support for subdir-ccflags-y
Date: Sat, 18 Apr 2009 23:17:44 -0400
Message-ID: <f73f7ab80904182017n7f27f49ck48ba200deb99388a@mail.gmail.com>
References: <20090418125159.GA23008@uranus.ravnborg.org>
	 <20090418125839.GA3668@flint.arm.linux.org.uk>
	 <20090418150750.GA24059@elte.hu>
	 <20090418180953.GE7148@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:5132 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbZDSDRp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 18 Apr 2009 23:17:45 -0400
In-Reply-To: <20090418180953.GE7148@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Apr 18, 2009 at 2:09 PM, Russell King <rmk+lkml@arm.linux.org.u=
k> wrote:
> On Sat, Apr 18, 2009 at 05:07:50PM +0200, Ingo Molnar wrote:
>> * Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>> > On Sat, Apr 18, 2009 at 02:51:59PM +0200, Sam Ravnborg wrote:
>> > > The typical use cases are an architecture or a subsystem that
>> > > decide to cover all files with -Werror.
>> > > Today alpha, mips and sparc uses -Werror in almost all their
>> > > Makefile - with subdir-ccflag-y it is now simpler to do so
>> > > as only the top-level directories needs to be covered.
>> >
>> > Hmm, this won't make sense for ARM. =C2=A0We have things like #war=
ning
>> > and deprecated functions in machine specific headers, and adding
>> > -Werror to the whole of arch/arm/ will result in these causing
>> > builds to fail.
>>
>> This is optional - if you dont want it, you dont set it.
>
> Please read _all_ of my mail, particularly the bit where it talks abo=
ut
> it being useful for a certain subset.

It's my impression that on x86 it's a config option whether or not to
build with -Werror.  You could do the exact same thing with an
internal inverted-logic CONFIG_ARM_ALLOW_WARNINGS option and make all
the boards triggering warnings "select ARM_ALLOW_WARNINGS".  Then have
a user-visible config option "ARM_USER_ALLOW_WARNINGS" which also
selects the internal option.  That adds some additional kconfig-level
documentation on which subarch combos need some love.

Cheers,
Kyle Moffett
