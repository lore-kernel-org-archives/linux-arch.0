Return-Path: <ralf@linux-mips.org>
Received: from p508B6C63.dip.t-dialin.net ([80.139.108.99]:22088 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264948AbUEQL2s
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2004 07:28:48 -0400
Date: Mon, 17 May 2004 13:28:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Allow arch override for kmem_bufctl_t
Message-ID: <20040517112831.GA25974@linux-mips.org>
References: <40A60984.1070202@colorfullife.com> <Pine.GSO.4.58.0405171111300.19405@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405171111300.19405@waterleaf.sonytel.be>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@digeo.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, May 17, 2004 at 11:11:59AM +0200, Geert Uytterhoeven wrote:

> > if there are no problems with 16-bit quantities. All accesses to
> > kmem_bufctl_t are under a per-cache spinlock and not in the hottest path.
> 
> 16-bit is no problem for m68k, so feel free to switch it.

No problem for MIPS either.

  Ralf
