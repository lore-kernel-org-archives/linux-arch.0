Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33884 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbaIOWnV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Sep 2014 18:43:21 -0400
Received: by mail-ig0-f173.google.com with SMTP id l13so4812799iga.0
        for <linux-arch@vger.kernel.org>; Mon, 15 Sep 2014 15:43:20 -0700 (PDT)
Date: Mon, 15 Sep 2014 23:43:17 +0100
From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] Support CrystalCove PMIC ACPI operation region
Message-ID: <20140915224317.GF25162@lee--X1>
References: <1410229968-11638-1-git-send-email-aaron.lu@intel.com>
 <20140915025727.GA14730@aaronlu.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140915025727.GA14730@aaronlu.sh.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Lejun Zhu <lejun.zhu@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID: <20140915224317.cc3ARwyb7WW3t6vSY82-LTzT2YN1umXKBF7a1-omXuc@z>

On Mon, 15 Sep 2014, Aaron Lu wrote:

> I wonder if anyone has looked at this?
> 
> Note that this is for CrystalCove PMIC operation region support and the
> CrystalCove driver is already in mainline, not for the DollarCove PMIC
> driver that Jacob is currently upstreaming, so the patch doesn't have
> any dependency.

Not yet.  It is on my list of TODOs though.

> On Tue, Sep 09, 2014 at 10:32:46AM +0800, Aaron Lu wrote:
> > The two patches add support for CrystalCove PMIC ACPI operation region.
> > The PMIC chip has two customized operation regions: one for power rail
> > manipulation and one for thermal purpose: sensor temperature reading
> > and trip point value reading/setting.
> > 
> > For an example ASL code on ASUS T100 with CrystalCove PMIC, see here:
> > https://gist.github.com/aaronlu/f5f65771a6c3251fae5d
> > 
> > Aaron Lu (2):
> >   gpio / CrystalCove: support virtual GPIO
> >   PMIC / opregion: support PMIC customized operation region for
> >     CrystalCove
> > 
> >  drivers/gpio/gpio-crystalcove.c           |  19 +-
> >  drivers/mfd/Kconfig                       |  11 +
> >  drivers/mfd/Makefile                      |   1 +
> >  drivers/mfd/intel_soc_pmic_crc.c          |   3 +
> >  drivers/mfd/intel_soc_pmic_crc_opregion.c | 229 +++++++++++++++++++
> >  drivers/mfd/intel_soc_pmic_opregion.c     | 350 ++++++++++++++++++++++++++++++
> >  drivers/mfd/intel_soc_pmic_opregion.h     |  35 +++
> >  include/asm-generic/gpio.h                |   2 +-
> >  8 files changed, 646 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/mfd/intel_soc_pmic_crc_opregion.c
> >  create mode 100644 drivers/mfd/intel_soc_pmic_opregion.c
> >  create mode 100644 drivers/mfd/intel_soc_pmic_opregion.h
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
