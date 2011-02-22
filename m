Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:43577 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247Ab1BVOTK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Feb 2011 09:19:10 -0500
From: "Guan Xuetao" <gxt@mprc.pku.edu.cn>
References: <02f301cbcb48$bebea4c0$3c3bee40$@mprc.pku.edu.cn> <201102171831.16713.arnd@arndb.de>
In-Reply-To: <201102171831.16713.arnd@arndb.de>
Subject: RE: [PATCHv2 09/11] unicore32 core architecture: timer and time handling
Date: Tue, 22 Feb 2011 22:19:04 +0800
Message-ID: <018c01cbd29b$759a4740$60ced5c0$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: zh-cn
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>
Message-ID: <20110222141904.Htu7wYYKmvtVjAEPLwfZtJVQEdVvqkBAP7VB8c7UT7s@z>



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Friday, February 18, 2011 1:31 AM
> To: Guan Xuetao
> Cc: linux-kernel@vger.kernel.org; linux-arch@vger.kernel.org; 'Greg KH'
> Subject: Re: [PATCHv2 09/11] unicore32 core architecture: timer and time handling
> 
> On Sunday 13 February 2011, Guan Xuetao wrote:
> 
> > diff --git a/arch/unicore32/include/asm/timex.h b/arch/unicore32/include/asm/timex.h
> > new file mode 100644
> > index 0000000..faf16ba
> > --- /dev/null
> > +++ b/arch/unicore32/include/asm/timex.h
> > +#ifndef __UNICORE_TIMEX_H__
> > +#define __UNICORE_TIMEX_H__
> > +
> > +#ifdef CONFIG_ARCH_FPGA
> > +
> > +/* in FPGA, APB clock is 33M, and OST clock is 32K, */
> > +/* so, 1M is selected for timer interrupt correctly */
> > +#define        CLOCK_TICK_RATE         (32*1024)
> > +
> > +#endif
> > +
> > +#if defined(CONFIG_PUV3_DB0913)                \
> > +       || defined(CONFIG_PUV3_NB0916)  \
> > +       || defined(CONFIG_PUV3_SMW0919)
> > +
> > +#define  CLOCK_TICK_RATE         (14318000)
> > +
> > +#endif
> 
> I believe that we don't use CLOCK_TICK_RATE in the kernel any more,
> so there is no reason to define it.
CLOCK_TICK_RATE is an important value for the kernel.
And perhaps I misunderstanding your meaning...
> 
> 	Arnd

Thanks & Regards.
Guan Xuetao

