From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] ARM: S5PV210: dependency issue,
 S5P_SLEEP is depend on ARM_CPU_SUSPEND
Date: Mon, 27 May 2013 19:12:11 +0900
Message-ID: <158201ce5ac2$a7843de0$f68cb9a0$%kim@samsung.com>
References: <5199E4AF.7040607@asianux.com> <51A32FD4.4000001@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53894 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242Ab3E0KMN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2013 06:12:13 -0400
In-reply-to: <51A32FD4.4000001@asianux.com>
Content-language: ko
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Chen Gang' <gang.chen@asianux.com>, ben-linux@fluff.org
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Linux-Arch' <linux-arch@vger.kernel.org>

Chen Gang wrote:
> 
> Hello Maintainers:
> 
Hi,

> Please help check this patch whether OK, when you have time.
> 
> 
> Thanks.
> 
> On 05/20/2013 04:54 PM, Chen Gang wrote:
> >
> > When randconfig with MMU for arm s5pv210 (and select all cpu type),
> > need let S5P_SLEEP depend on ARM_CPU_SUSPEND, or will cause issue below:
> >
> >   arch/arm/plat-samsung/built-in.o: In function `s3c_cpu_resume':
> >   arch/arm/plat-samsung/s5p-sleep.S:83: undefined reference to
> `cpu_resume'
> >
> >
> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> > ---
> >  arch/arm/plat-samsung/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-
> samsung/Kconfig
> > index f8ed2de..1d38541 100644
> > --- a/arch/arm/plat-samsung/Kconfig
> > +++ b/arch/arm/plat-samsung/Kconfig
> > @@ -483,6 +483,7 @@ config S5P_PM
> >
> >  config S5P_SLEEP
> >  	bool
> > +	select ARM_CPU_SUSPEND

Probably,

+	select ARM_CPU_SUSPEND if PM ?

selecting the S5P_SLEEP depends on PM though...

- Kukjin
