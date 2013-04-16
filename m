From: Christian Ruppert <christian.ruppert@abilis.com>
Subject: Re: [PATCH v2 0/4] remove GENERIC_GPIO
Date: Tue, 16 Apr 2013 09:34:59 +0200
Message-ID: <20130416073459.GA30238@ab42.lan>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com>
 <5166C331.7060404@synopsys.com>
 <CAAVeFuJ1T9FyBLBkxBGsWNppU66+7a2pzJVYieakNsEw35=9Ug@mail.gmail.com>
 <20130415074322.GC3264@ab42.lan>
 <516CB71D.9070603@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.abilis.ch ([195.70.19.74]:29720 "EHLO mail.abilis.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab3DPHfX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 03:35:23 -0400
Content-Disposition: inline
In-Reply-To: <516CB71D.9070603@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Courbot <acourbot@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, sascha leuenberger <sascha.leuenberger@abilis.com>

On Tue, Apr 16, 2013 at 11:27:41AM +0900, Alex Courbot wrote:
> On 04/15/2013 04:43 PM, Christian Ruppert wrote:
> >Hello Alexandre,
> >
> >On Fri, Apr 12, 2013 at 11:42:42AM -0700, Alexandre Courbot wrote:
> >>Hi Vineet,
> >>
> >>On Thu, Apr 11, 2013 at 7:05 AM, Vineet Gupta
> >><Vineet.Gupta1@synopsys.com> wrote:
> >>>I'm the maintainer for arch/arc.
> >>>
> >>>For 3.10, we are going to have a sub-platform included which enabl=
es GPIO.
> >>>However given that your patch is still not in a maintainer tree I'=
m going to apply
> >>>the platform patch with GENERIC_GPIO and it would show up in -next=
 as well. But
> >>>don't be alarmed - to align with your work, Christian or you can t=
hen possibly
> >>>apply a patch to make arch/arc/* confirm to your work - preferably=
 via your
> >>>tree/patchseries  - OK ?
> >>
> >>I guess that would work, but since I assume your platforms' GPIO
> >>implementation use gpiolib anyway wouldn't it be simpler and more
> >>logical to directly require it?
> >>
> >>If you have reasons for not doing so I'm ok with doing the switch
> >>later too, anyway that's what I had to do for all the other archs.
> >
> >The GPIO driver patch was proposed on lkml a few days ago and althou=
gh I
> >am not aware of any "GENERIC" methods it uses it does not compile
> >without GENERIC_GPIO being defined (errors in of_gpio.h etc). You ca=
n
> >review the patch at https://lkml.org/lkml/2013/4/10/385.
> >
> >We'd be happy to accept any guidance on how to remove GENERIC_GPIO.
> >Also, I'm not sure the custom interface to the pin controller is a g=
reat
> >solution and suggestions are welcome. The goal is to remove redundan=
cy
> >between the drivers in the definition of pin groups.
>=20
> Hi Christian,
>=20
> Thanks for the link to the patch. This is rather puzzling - in
> drivers/gpio/Kconfig your GPIO_TB10X config option seems to be under
> the "if GPIOLIB" condition which is what I expect, since your driver
> uses gpiolib. If you go to the GPIOLIB config option, you notice
> that is explicitly selects GENERIC_GPIO as a result of being
> enabled. Therefore CONFIG_GENERIC_GPIO should always be defined
> whenever your driver is compiled and it should not be needed to
> select it elsewhere. Do we agree on that?
>=20
> I'd really like to go to the bottom of this since I saw several
> similar issues already, but I don't understand how this can happen
> at all. Having the .config of both the working (with GENERIC_GPIO
> selected) and non-working (only GPIOLIB selected) cases would
> probably be helpful, could you send them to me?
>=20
> Thanks,
> Alex.

Hello Alexandre,

Thanks for taking a look at the driver. I think the issue we see is due
to the fact that "Platforms must declare GENERIC_GPIO support in their
Kconfig (boolean true)" (from Documentation/gpio.txt). This seems to be
still the case at the moment and I haven't found a way around it.
Removing the config GENERIC_GPIO section from our platform's Kconfig
(see arch/arc/plat-tb10x/Kconfig in linux-next) results in compilation
errors. This seems logical since "config GPIOLIB" only selects
GENERIC_GPIO but assumes it is defined elsewhere.

We were wondering if we could get rid of the "config GENERIC_GPIO"
section in the new platform's Kconfig in order to avoid adding things
you are going to remove again soon and in order to check if there aren'=
t
any hidden dependencies on GENERIC_GPIO in the driver. Do I understand
your mail correctly that this is not yet possible?

Greetings,
  Christian

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
