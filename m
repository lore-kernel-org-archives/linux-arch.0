From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/24] C6X: interrupt handling
Date: Mon, 22 Aug 2011 22:58:48 +0200
Message-ID: <2384053.HX3gjK1Rxm@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-12-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56100 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab1HVU70 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 16:59:26 -0400
In-Reply-To: <1314043785-2880-12-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Monday 22 August 2011 16:09:32 Mark Salter wrote:
> 
> Most of the code in arch/c6x/kernel/irq.c which supports mapping of hardware
> interrupts to virtual kernel interrupts was taken as-is from powerpc. Very
> few changes were necessary for C6X, so separating that out into the generic
> kernel interrupt code may be worthwhile for cases where other architectures
> may want to use it.

What's the status on this? Did you talk about this with Thomas and/or BenH?

	Arnd
