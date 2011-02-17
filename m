From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/12] unicore32 additional architecture files: low-level lib: uaccess
Date: Thu, 17 Feb 2011 18:45:00 +0100
Message-ID: <201102171845.01177.arnd@arndb.de>
References: <014b01cbcdad$f110afb0$d3320f10$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63333 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab1BQRpE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2011 12:45:04 -0500
In-Reply-To: <014b01cbcdad$f110afb0$d3320f10$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>

On Wednesday 16 February 2011, Guan Xuetao wrote:
> +
> +#define __kernel_ok		(segment_eq(get_fs(), KERNEL_DS))
> +#define __user_ok(addr, size)	(((size) <= TASK_SIZE)			\
> +				&& ((addr) <= TASK_SIZE - (size)))
> +#define __access_ok(addr, size)	(__kernel_ok || __user_ok((addr), (size)))

A nice trick to simplify this is to introduce a per-process variable for comparing
the pointer, set_fs() then sets this variable to either TASK_SIZE or
UINT_MAX.

This saves one conditional branch for each call to __access_ok.

	Arnd
