Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:47962 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab1BZMg2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Feb 2011 07:36:28 -0500
From: "Guan Xuetao" <gxt@mprc.pku.edu.cn>
References: <015701cbcdae$7d5f43f0$781dcbd0$@mprc.pku.edu.cn> <201102181133.26675.arnd@arndb.de> <019001cbd29c$7cee6340$76cb29c0$@mprc.pku.edu.cn> <201102221811.58441.arnd@arndb.de>
In-Reply-To: <201102221811.58441.arnd@arndb.de>
Subject: RE: [PATCH 11/12] unicore32 machine related files: ps2 driver
Date: Sat, 26 Feb 2011 20:36:16 +0800
Message-ID: <011101cbd5b1$c34f6880$49ee3980$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: zh-cn
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>
Message-ID: <20110226123616.z68IVjLr9rSzAy-9As0TBcybGba6Z4expMXlY1V8gSM@z>



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, February 23, 2011 1:12 AM
> To: Guan Xuetao
> Cc: dmitry.torokhov@gmail.com; linux-kernel@vger.kernel.org; linux-arch@vger.kernel.org; 'Greg KH'
> Subject: Re: [PATCH 11/12] unicore32 machine related files: ps2 driver
> 
> On Tuesday 22 February 2011, Guan Xuetao wrote:
> > diff --git a/drivers/input/serio/i8042-unicore32io.h b/drivers/input/serio/i8042-unicore32io.h
> > index 2cdd872..9350843 100644
> > --- a/drivers/input/serio/i8042-unicore32io.h
> > +++ b/drivers/input/serio/i8042-unicore32io.h
> > @@ -29,11 +29,11 @@
> >  /*
> >   * Register numbers.
> >   */
> > -#define I8042_COMMAND_REG      ((volatile void __iomem *)&PS2_COMMAND)
> > -#define I8042_STATUS_REG       ((volatile void __iomem *)&PS2_STATUS)
> > -#define I8042_DATA_REG         ((volatile void __iomem *)&PS2_DATA)
> > +#define I8042_COMMAND_REG      PS2_COMMAND
> > +#define I8042_STATUS_REG       PS2_STATUS
> > +#define I8042_DATA_REG         PS2_DATA
> 
> I wouldn't bother defining two sets of macros then. Either use PS2_COMMAND
> in the driver, or define I8042_COMMAND_REG in the place where you currently
> define PS2_COMMAND.
All I8042_*_REGs are explicitly defined in i8042-*io.h files.
And I want to reserve the original register names in unicore32 namespace.
> 
> Aside from this, it looks good.
> 
> 	Arnd
Thanks & Regards.
Guan Xuetao

