Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:58787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264554AbUDTV1e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Apr 2004 17:27:34 -0400
Date: Tue, 20 Apr 2004 14:29:47 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: "[PATCH] idr.c: extra features enhancements" breaks some archs
Message-Id: <20040420142947.6501c5c4.akpm@osdl.org>
In-Reply-To: <200404202259.43931.bzolnier@elka.pw.edu.pl>
References: <200404202259.43931.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: jim.houston@comcast.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@408422f91NJQZKJweeY7yvmNfDTRmg?nav=index.html|ChangeSet@-2d
> 
> > [PATCH] idr.c: extra features enhancements
> 
> This patch adds find_next_bit() call to lib/idr.c but find_next_bit()
> is not implemented on arm, arm26, cris, h8300, m68k, m68knommu, um and v850.
> 
> Please fix it...
> 

eww, how irritating.

find_next_bit() is used in:

- the cpumask code

- Andi's NUMA code

- drivers/atm/lanai.c

- the sched-domains patches in -mm

- and, now, lib/idr.c


the above architectures simply hadn't stumbled across it, but now they
have.

There are fairly generic-looking implementations of find_next_bit() in
alpha, parisc, others.

Could I please ask the relevant arch maintainers to prepare an implementation?

Thanks.
