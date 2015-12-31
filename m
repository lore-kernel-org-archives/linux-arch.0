Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46014 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbLaToH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Dec 2015 14:44:07 -0500
Date: Thu, 31 Dec 2015 14:44:03 -0500 (EST)
Message-ID: <20151231.144403.84288151398339321.davem@davemloft.net>
Subject: Re: [PATCH v2 24/32] sparc: define __smp_xxx
From: David Miller <davem@davemloft.net>
In-Reply-To: <1451572003-2440-25-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-25-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de, linux-arch@vger.kernel.org, andrew.cooper3@citrix.com, virtualization@lists.linux-foundation.org, stefano.stabellini@eu.citrix.com, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, mingo@kernel.org, ralf@linux-mips.org, andreyknvl@google.com
Message-ID: <20151231194403.VDWO9QPt4j_QBUZpO-pIk5OyS7_GrHRTWCgk738S82Q@z>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 31 Dec 2015 21:08:53 +0200

> This defines __smp_xxx barriers for sparc,
> for use by virtualization.
> 
> smp_xxx barriers are removed as they are
> defined correctly by asm-generic/barriers.h
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
