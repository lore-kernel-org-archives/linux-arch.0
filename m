Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:47150 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbYFZSVW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 14:21:22 -0400
Message-ID: <4863CB8A.7000204@zytor.com>
Date: Thu, 26 Jun 2008 10:02:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 59/60] microblaze_v4: syscall_table.S and unistd.h
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-59-git-send-email-monstr@seznam.cz> <1214483429-32360-60-git-send-email-monstr@seznam.cz> <200806261831.19187.arnd@arndb.de>
In-Reply-To: <200806261831.19187.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: monstr@seznam.cz, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, Michal Simek <monstr@monstr.eu>
Message-ID: <20080626170202.NrSbg3ea2bFlqBwldIb6i4ohcooNvvp-eGqxRUD-H2w@z>

Arnd Bergmann wrote:
> 
> You still set __NR_fork. There is no point defining the number if you
> can't actually call the syscall in the first place.
> 

Worse, it is actively *harmful* to set the number; klibc or anything 
that uses similar kinds of scripts for portability will see the symbol 
and think the system call is available.

	-hpa
