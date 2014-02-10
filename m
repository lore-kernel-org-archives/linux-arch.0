From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 58/73] drivers/mfd: delete non-required instances of
 include <linux/init.h>
Date: Mon, 10 Feb 2014 12:16:28 +0000
Message-ID: <20140210121628.GI22773@lee--X1>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-59-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40060 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbaBJMQe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Feb 2014 07:16:34 -0500
Received: by mail-wi0-f170.google.com with SMTP id hi5so2647227wib.1
        for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2014 04:16:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390339396-3479-59-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
>=20
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
