From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/27] score: create Kconfig Kconfig.debug Makefile
Date: Sun, 14 Jun 2009 00:44:03 +0200
Message-ID: <200906140044.04440.arnd@arndb.de>
References: <OF2086513E.4B4F803C-ON482575D0.0022E294-482575D0.0023688F@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:51131 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbZFMWoc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Jun 2009 18:44:32 -0400
In-Reply-To: <OF2086513E.4B4F803C-ON482575D0.0022E294-482575D0.0023688F@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:
> +
> +config MMU
> +       bool
> +       default y
> +

After reading through the code again, I came across this defintion, which
confused me a bit. The source code clearly assumes a NOMMU architecture, but
this one enables the kernel support for MMU.

Is MMU support something that you plan to add later and is possible with
the hardware, or is this one wrong?

	Arnd <><
