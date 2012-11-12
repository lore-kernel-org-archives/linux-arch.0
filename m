From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 45/55] ARC: unaligned access emulation
Date: Mon, 12 Nov 2012 14:00:12 +0000
Message-ID: <201211121400.13046.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-15-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58520 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2KLOAU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 09:00:20 -0500
In-Reply-To: <1352720953-24321-15-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet.Gupta1@synopsys.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
> +
> +config ARC_MISALIGN_ACCESS
> +       bool "Emulate unaligned memory access (userspace only)"
> +       default N
> +       help
> +         This enables misaligned 16 & 32 bit memory access from user space.
> +         Use ONLY-IF-ABS-NECESSARY as it will be very slow and also can hide
> +         potential bugs in code

parisc and ia64 both have the same feature, and they use sysctl to configure
it at run-time. Maybe you should pick one of the two sysctl implementations
and hook that up to your implementation as well.

	Arnd
