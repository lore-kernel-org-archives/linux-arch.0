From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 1/5] vmlinux.lds.h: Include *(.text.*) in TEXT_TEXT
Date: Thu, 17 Jun 2010 20:54:23 +0200
Message-ID: <AANLkTik0QxlSuBk0AKHBMET415vcYhaXSWNQf0GVeBn0@mail.gmail.com>
References: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
	<alpine.DEB.1.10.1006141014360.1432@dr-wily.mit.edu>
	<87y6ehxvby.fsf@linux-g6p1.site>
	<1276545951.5374.260.camel@mulgrave.site>
	<alpine.DEB.1.10.1006141608550.1248@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56248 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933093Ab0FQSyY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jun 2010 14:54:24 -0400
In-Reply-To: <alpine.DEB.1.10.1006141608550.1248@dr-wily.mit.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tim Abbott <tabbott@ksplice.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <mmarek@suse.cz>

On Tue, Jun 15, 2010 at 12:02 AM, Tim Abbott <tabbott@ksplice.com> wrot=
e:
> On Mon, 14 Jun 2010, James Bottomley wrote:
>
>> On Mon, 2010-06-14 at 20:33 +0100, Matt Fleming wrote:
>> > On Mon, 14 Jun 2010 10:32:46 -0400 (EDT), Tim Abbott <tabbott@kspl=
ice.com> wrote:
>> > >
>> > > I was planning to submit in the next couple weeks a change that =
adds
>> > > support for building the kernel with -ffunction-sections -fdata-=
sections,
>> > > which would have as a piece of it adding to TEXT_TEXT the follow=
ing
>> > > expression:
>> > >
>> > > =A0 *(.text.[A-Za-z$_]*) =A0 =A0/* handle -ffunction-sections */=
\
>>
>> Just as a point of technical interest, that won't handle
>> -ffunction-sections. =A0At least on parisc, we get a
>> section .text.<function name> for every function. =A0This means that=
 any
>> character legal in a function name can appear there, not just letter=
s
>> and underscores (we get millicode ones with dollar signs as well for
>> instance). =A0That's why *(.text.*) is safer
>
> Hi James,
>
> I believe that the pattern [A-Za-z$_] matches all valid characters to
> start a function name (in particular, it includes "$"). =A0If I'm mis=
sing
> any valid characters for the start of a function name, please correct=
 me.

Yes, I think we need to add 0-9 too. C names can't have a digit as a st=
arting
character, but linker can produce such names when invoked as "ld -r --u=
nique"
(incremental linking).

Currently we use just "ld -r" to combine all .o files from a directory
into one bigger .o file, but this combines all similarly-named sections=
=2E
This not only combines all .text sections from every input .o file
into one .text section (which isn't surprising), but also combines
all .text.func sections too. Which we don't want to happen when we
(eventually) want to link kernel with --gc-sections.

The fix already exists: "ld -r --unique". With --unique, ld
will create unique sections named .text.1, .text.2, .text.func.1
and such.

Therefore, in order to accomodate .text.NUM sections in the future,
we'd better use .text.[A-Za-z0-9$_]* pattern.

--=20
vda
