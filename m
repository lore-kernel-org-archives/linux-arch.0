From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: ARM: add support to dump the kernel page tables
Date: Tue, 26 Nov 2013 14:50:52 +0100
Message-ID: <20131126135052.GH28642@pengutronix.de>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36436 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896Ab3KZNu4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2013 08:50:56 -0500
Content-Disposition: inline
In-Reply-To: <20131024071600.GC16735@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

Hello Russell,

On Thu, Oct 24, 2013 at 08:16:00AM +0100, Russell King - ARM Linux wrot=
e:
> +config ARM_PTDUMP
> +	bool "Export kernel pagetable layout ot userspace via debugfs"

just noticed while doing make oldconfig on next: You want to make
s/ot/to/ on that line.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
