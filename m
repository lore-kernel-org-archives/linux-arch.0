From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 24/60] microblaze_v4: asm-offsets
Date: Sat, 28 Jun 2008 13:43:58 +0900
Message-ID: <20080628044358.GE25492@linux-sh.org>
References: <1214483429-32360-16-git-send-email-monstr@seznam.cz> <1214483429-32360-17-git-send-email-monstr@seznam.cz> <1214483429-32360-18-git-send-email-monstr@seznam.cz> <1214483429-32360-19-git-send-email-monstr@seznam.cz> <1214483429-32360-20-git-send-email-monstr@seznam.cz> <1214483429-32360-21-git-send-email-monstr@seznam.cz> <1214483429-32360-22-git-send-email-monstr@seznam.cz> <1214483429-32360-23-git-send-email-monstr@seznam.cz> <1214483429-32360-24-git-send-email-monstr@seznam.cz> <1214483429-32360-25-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:23237 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751950AbYF1ErD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Jun 2008 00:47:03 -0400
Content-Disposition: inline
In-Reply-To: <1214483429-32360-25-git-send-email-monstr@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

On Thu, Jun 26, 2008 at 02:29:53PM +0200, monstr@seznam.cz wrote:
> +#include <linux/stddef.h>
> +#include <linux/sched.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/ptrace.h>
> +#include <linux/hardirq.h>
> +#include <linux/thread_info.h>
> +
> +#define DEFINE(sym, val) asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> +#define BLANK() asm volatile("\n->" : :)
> +
There are generic definitions for these these days, include linux/kbuild.h.
