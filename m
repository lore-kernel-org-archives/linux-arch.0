From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 26/60] microblaze_v4: time support
Date: Fri, 27 Jun 2008 12:43:00 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0806271240461.3297@apollo.tec.linutronix.de>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-12-git-send-email-monstr@seznam.cz> <1214483429-32360-13-git-send-email-monstr@seznam.cz> <1214483429-32360-14-git-send-email-monstr@seznam.cz> <1214483429-32360-15-git-send-email-monstr@seznam.cz>
 <1214483429-32360-16-git-send-email-monstr@seznam.cz> <1214483429-32360-17-git-send-email-monstr@seznam.cz> <1214483429-32360-18-git-send-email-monstr@seznam.cz> <1214483429-32360-19-git-send-email-monstr@seznam.cz> <1214483429-32360-20-git-send-email-monstr@seznam.cz>
 <1214483429-32360-21-git-send-email-monstr@seznam.cz> <1214483429-32360-22-git-send-email-monstr@seznam.cz> <1214483429-32360-23-git-send-email-monstr@seznam.cz> <1214483429-32360-24-git-send-email-monstr@seznam.cz> <1214483429-32360-25-git-send-email-monstr@seznam.cz>
 <1214483429-32360-26-git-send-email-monstr@seznam.cz> <1214483429-32360-27-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:38565 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbYF0KqL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2008 06:46:11 -0400
In-Reply-To: <1214483429-32360-27-git-send-email-monstr@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

On Thu, 26 Jun 2008, monstr@seznam.cz wrote:
> +
> +static inline void udelay(unsigned long usec)
> +{
> +}

shouldnt this function be named zerodelay() ?

Thanks,
	tglx
