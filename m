Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56629 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253Ab2GAL6S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Jul 2012 07:58:18 -0400
Received: by lbbgm6 with SMTP id gm6so6535547lbb.19
        for <linux-arch@vger.kernel.org>; Sun, 01 Jul 2012 04:58:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120701105934.GD16319@n2100.arm.linux.org.uk>
References: <4FECB95D.7010200@zytor.com>
	<cover.1338222460.git.rubini@gnudd.com>
	<f85fefb10b7a7407b77180be65b18bf0426145b9.1338222461.git.rubini@gnudd.com>
	<20120701104401.GA4352@mail.gnudd.com>
	<20120701105934.GD16319@n2100.arm.linux.org.uk>
Date: Sun, 1 Jul 2012 17:28:16 +0530
Message-ID: <CAJe_ZheynaBcMiQiwnxPrEoGxhhAJyHDD6VM-uDEN_5Yg1vVpA@mail.gmail.com>
Subject: Re: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
From: Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alessandro Rubini <rubini@gnudd.com>, linux-arch@vger.kernel.org, giancarlo.asnaghi@st.com, arnd@arndb.de, gregkh@linuxfoundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, hpa@zytor.com, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
Message-ID: <20120701115816.eoaPX9cKqmZrR3c61ySAzV65zmXpRyhbohu95k-JU28@z>

On 1 July 2012 16:29, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Sun, Jul 01, 2012 at 12:44:01PM +0200, Alessandro Rubini wrote:
>> How should I address the problem? (original code, published on
>> sourceforge was simply replicating a number of amba drivers into pci
>> drivers, but I don't think massive code duplication is ever sensible,
>> thus I preferred to reuse the existing drivers).
>
> I think the answer is... those primecell drivers need fixing in some way.
> Re-defining CS, DS and ES in drivers is rather silly given that they're
> x86 segment register names - so if PL330 can be fixed to make its names
> more specific, that sorts it out.
>
I am OK prefixing the regs with PL330_ or somesuch.

The CS, DS and ES regs were named so as to match exactly the
terminology of the PL330 manual. So apparently even the ARM Ltd didn't
imagine ARM and X86 galaxies colliding so soon :)

Regards.
