From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] ARM: S5PV210: dependency issue, S5P_SLEEP is depend on
 ARM_CPU_SUSPEND
Date: Mon, 27 May 2013 18:49:55 +0800
Message-ID: <51A33A53.1050502@asianux.com>
References: <5199E4AF.7040607@asianux.com> <51A32FD4.4000001@asianux.com> <158201ce5ac2$a7843de0$f68cb9a0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:50617 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757456Ab3E0Kup (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2013 06:50:45 -0400
In-Reply-To: <158201ce5ac2$a7843de0$f68cb9a0$%kim@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: ben-linux@fluff.org, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Linux-Arch' <linux-arch@vger.kernel.org>

On 05/27/2013 06:12 PM, Kukjin Kim wrote:
>>>  config S5P_SLEEP
>>> > >  	bool
>>> > > +	select ARM_CPU_SUSPEND
> Probably,
> 
> +	select ARM_CPU_SUSPEND if PM ?
> 
> selecting the S5P_SLEEP depends on PM though...

After reference another platform, they are really all "select
ARM_CPU_SUSPEND if PM", we'd really better to follow by to let readers
easy understanding.

I will send patch v2.


Thanks.
-- 
Chen Gang

Asianux Corporation
