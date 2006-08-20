Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:16875 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751121AbWHTSZn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 Aug 2006 14:25:43 -0400
Date: Sun, 20 Aug 2006 11:25:23 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] introduce kernel_execve function to replace
 __KERNEL_SYSCALLS__
Message-Id: <20060820112523.f14fc6dc.akpm@osdl.org>
In-Reply-To: <200608201237.13194.chase.venters@clientec.com>
References: <20060819073031.GA25711@atjola.homenet>
	<20060820134745.GA11843@atjola.homenet>
	<200608201913.39989.arnd@arndb.de>
	<200608201237.13194.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
Cc: Arnd Bergmann <arnd@arndb.de>, =?ISO-8859-1?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 20 Aug 2006 12:36:49 -0500
Chase Venters <chase.venters@clientec.com> wrote:

> Unless 'errno' has some significant reason to live on in the kernel, I think 
> it would be better to kill it and write kernel syscall macros that don't muck 
> with it.

We have been working in that direction.  It's certainly something we'd like
to kill off.
