From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 16 Jun 2009 04:06:48 -0400
Message-ID: <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<4A373EE6.6070201@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:58863 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbZFPIc4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2009 04:32:56 -0400
In-Reply-To: <4A373EE6.6070201@compulab.co.il>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <mike@compulab.co.il>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On Tue, Jun 16, 2009 at 02:42, Mike Rapoport wrote:
> James Bottomley wrote:
>> We've got to the point where there are simply too many embedded
>> architectures to invite all the arch maintainers to the kernel summi=
t.
>> So, this year, we thought we'd do embedded via topic driven invitati=
ons
>> instead. =C2=A0So what we're looking for is a proposal to discuss th=
e issues
>> most affecting embedded architectures, or preview any features affec=
ting
>> the main kernel which embedded architectures might need ... or any o=
ther
>> topics from embedded architectures which might need discussion or
>> debate.
>
> Another issue that affects embedded architectures is drivers initiali=
zation
> order. There are a lot of cases when you need the drivers to be initi=
alized in
> particular order, and current initcalls scheme does not allow fine gr=
ained
> control for it.

example: device configuration information stored in i2c eeprom (i.e.
dimensions of attached framebuffer), but i2c is not available when
framebuffer layer is setup.  framebuffer driver has to be built as a
module and loaded by userspace, or i2c information is read by
bootloader and passed down to the kernel.
-mike
