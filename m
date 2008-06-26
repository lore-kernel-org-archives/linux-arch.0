From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
Date: Thu, 26 Jun 2008 16:44:17 -0500
Message-ID: <48640DB1.7020500@freescale.com>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	<1214483429-32360-2-git-send-email-monstr@seznam.cz>	<1214483429-32360-3-git-send-email-monstr@seznam.cz>	<1214483429-32360-4-git-send-email-monstr@seznam.cz>	<1214483429-32360-5-git-send-email-monstr@seznam.cz>	<1214483429-32360-6-git-send-email-monstr@seznam.cz>	<1214483429-32360-7-git-send-email-monstr@seznam.cz>	<1214483429-32360-8-git-send-email-monstr@seznam.cz>	<1214483429-32360-9-git-send-email-monstr@seznam.cz>	<1214483429-32360-10-git-send-email-monstr@seznam.cz>	<1214483429-32360-11-git-send-email-monstr@seznam.cz>	<1214483429-32360-12-git-send-email-monstr@seznam.cz>	<1214483429-32360-13-git-send-email-monstr@seznam.cz><4863B096.7020309@freescale.com>	<4863E68C.30802@seznam.cz> <20080626201813.9662411E0051@mail20-
 wa4.bigfish.com> <48640CF7.7050700@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from az33egw01.freescale.net ([192.88.158.102]:43112 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYFZVpF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 17:45:05 -0400
In-Reply-To: <48640CF7.7050700@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, linux-arch@vger.kernel.org, john.williams@petalogix.com, arnd@arndb.de, vapier.adi@gmail.com, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com, John Linn <linnj@xilinx.com>, drepper@redhat.com, alan@lxorguk.ukuu.org.uk

Michal Simek wrote:
> Ok. Thanks for information Steve.
> 
> Jon: Only for sure the main difference is only in value handling. Am I right?
> If yes, it is easy to change.
> 
> M

Right.  It is essentially C-like now.  And has a
declarator at the top with /dts-v1/.  Essentially
all of the DTS files in arch/powerpc/boot/dts should
be V1 now.  Lots of examples.

Except in Byte Arrays:  x = [ CA FE BA BE FE ED D0 0D ];

jdl
