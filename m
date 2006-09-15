Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41407 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750787AbWIOKrl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 06:47:41 -0400
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <450A31D4.1020108@linux.intel.com>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
	 <450A31D4.1020108@linux.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 12:10:08 +0100
Message-Id: <1158318608.29932.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

Ar Gwe, 2006-09-15 am 06:53 +0200, ysgrifennodd Arjan van de Ven:
> This patch will create a userspace ABI precedent that will hurt us if we ever
> decide to implement this, or if Intel or AMD add support for this to the cpu...

You mean like noexec didn't. It's just a question of binary type if such
a mapping type comes into existance. At the moment the behaviour is
essentially random.

Alan
