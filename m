From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 01/10] percpu: use dynamic percpu allocator as the default percpu allocator
Date: Thu, 25 Jun 2009 13:44:44 +0900
Message-ID: <20090625044444.GA19871@linux-sh.org>
References: <1245825924-30412-1-git-send-email-tj@kernel.org> <1245825924-30412-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:56630 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbZFYEpq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2009 00:45:46 -0400
Content-Disposition: inline
In-Reply-To: <1245825924-30412-2-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, torvalds@linux-foundation.org, akpm@linux-foundation.org, Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@kernel.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Hirokazu Takata <takata@linux-m32r.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Wed, Jun 24, 2009 at 03:45:15PM +0900, Tejun Heo wrote:
> This patch makes most !CONFIG_HAVE_SETUP_PER_CPU_AREA archs use
> dynamic percpu allocator.  The first chunk is allocated using
> embedding helper and 8k is reserved for modules.  This ensures that
> the new allocator behaves almost identically to the original allocator
> as long as static percpu variables are concerned, so it shouldn't
> introduce much breakage.
> 
> s390 and alpha use custom SHIFT_PERCPU_PTR() to work around addressing
> range limit the addressing model imposes.  Unfortunately, this breaks
> if the address is specified using a variable, so for now, the two
> archs aren't converted.
> 
> The following architectures are affected by this change.
> 
> * sh
> * arm
> * cris
> * mips
> * sparc(32)
> * blackfin
> * avr32
> * parisc (broken, under investigation)
> * m32r
> * powerpc(32)
> 
No problems on sh.

Acked-by: Paul Mundt <lethal@linux-sh.org>
