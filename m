From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 16 Jun 2009 10:06:44 -0600
Message-ID: <fa686aa40906160906i7a05fc77jd1b2b920a1680812@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:33040 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZFPQHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2009 12:07:04 -0400
In-Reply-To: <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On Tue, Jun 16, 2009 at 2:06 AM, Mike Frysinger<vapier.adi@gmail.com> w=
rote:
> On Tue, Jun 16, 2009 at 02:42, Mike Rapoport wrote:
>> James Bottomley wrote:
>> Another issue that affects embedded architectures is drivers initial=
ization
>> order. There are a lot of cases when you need the drivers to be init=
ialized in
>> particular order, and current initcalls scheme does not allow fine g=
rained
>> control for it.
>
> example: device configuration information stored in i2c eeprom (i.e.
> dimensions of attached framebuffer), but i2c is not available when
> framebuffer layer is setup. =A0framebuffer driver has to be built as =
a
> module and loaded by userspace, or i2c information is read by
> bootloader and passed down to the kernel.

I experimented a bit with having some infrastructure for waiting for
another device to get either registered as part of the phylib stuff I
was doing.  Here's the patchwork link to the discussion:

http://patchwork.ozlabs.org/patch/24152/

I never actually pushed through and finished it because it turned out
to be a non-issue for Ethernet devices in the end.  However, I can see
the value.  With this approach, a driver can use a
bus_register_notifier() variant without caring about the device
registration order, and the drivers notifier callback will get called
at the appropriate time.

In your example case I could see the framebuffer driver deferring the
final part of its initialization until the needed i2c device shows up.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
