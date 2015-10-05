Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51173 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbJEK6I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2015 06:58:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
Date: Mon, 05 Oct 2015 12:58:04 +0200
Message-ID: <5166889.dum1bb5mjD@wuerfel>
In-Reply-To: <1444038969-14112-1-git-send-email-manjeet.p@samsung.com>
References: <1444038969-14112-1-git-send-email-manjeet.p@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Manjeet Pawar <manjeet.p@samsung.com>
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, pankaj.m@samsung.com, Akhilesh Kumar <akhilesh.k@samsung.com>, Rohit Thapliyal <r.thapliyal@samsung.com>
Message-ID: <20151005105804.16gsE9-GaI9crA_ZQyhIoYxW6gA5nnnYQ1PQVOGSlUs@z>

On Monday 05 October 2015 15:26:09 Manjeet Pawar wrote:
> -#define MINSIGSTKSZ    2048
> -#define SIGSTKSZ       8192
> +#ifdef CONFIG_ARM64
> +#define MINSIGSTKSZ 5120
> +#define SIGSTKSZ    16384
> +#else
> +#define MINSIGSTKSZ 2048
> +#define SIGSTKSZ    8192
> +#endif

uapi header files cannot use CONFIG_* symbols, as they are not visible
in user space.

If these have to be architecture-specific, override them in
arch/arm64/include/uapi/asm/signal.h

	Arnd
