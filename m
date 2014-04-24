From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/4] vmlinux.lds.h clean-ups
Date: Thu, 24 Apr 2014 15:23:01 +0200
Message-ID: <201404241523.01452.arnd@arndb.de>
References: <1395949317-8738-1-git-send-email-robherring2@gmail.com> <CAL_JsqKn_erNnGwdXwg6C08pHHQuQn-4fpmp70agvH5ok=P9-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55800 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbaDXNXH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Apr 2014 09:23:07 -0400
In-Reply-To: <CAL_JsqKn_erNnGwdXwg6C08pHHQuQn-4fpmp70agvH5ok=P9-g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh@kernel.org>

On Tuesday 15 April 2014, Rob Herring wrote:
> >
> >  arch/arm/kernel/devtree.c         |  11 +--
> >  drivers/irqchip/irqchip.c         |   6 +-
> >  include/asm-generic/vmlinux.lds.h | 142 +++++++++++---------------------------
> 
> Arnd, Any comments on this series?
> 

No qualified comments. The linker script is always magic to me. For all I can
tell, it's all good and you can add an Acked-by from me if that helps you,
but I'm not able to judge whether it's correct. Do you want to merge it
through the DT git?

	Arnd
