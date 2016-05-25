Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42355 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcEYTaU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2016 15:30:20 -0400
Date: Wed, 25 May 2016 12:30:17 -0700 (PDT)
Message-ID: <20160525.123017.1597296248000772613.davem@davemloft.net>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
	<1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ynorov@caviumnetworks.com
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
Message-ID: <20160525193017.cnZx8B0xKUcfm8y3k4WkvkZekn7CWAfxJ_VJP-OkTXo@z>

From: Yury Norov <ynorov@caviumnetworks.com>
Date: Tue, 24 May 2016 03:04:30 +0300

> +To clear that top halves, automatic wrappers are introduced. They clear all
> +required registers before passing control to regular syscall handler.

Why have one of these for every single compat system call, rather than
simply clearing the top half of all of these registers unconditionally
in the 32-bit system call trap before the system call is invoked?

That's what we do on sparc64.

And with that, you only need wrappers for the case where there needs
to be proper sign extention of a 32-bit signed argument.
