Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49186 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756601AbYFZRpH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 13:45:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or redirect to asm-generic
Date: Thu, 26 Jun 2008 18:38:32 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <200806261735.12738.arnd@arndb.de> <20080626162118.GG22025@cs181140183.pp.htv.fi>
In-Reply-To: <20080626162118.GG22025@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200806261838.33787.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: monstr@seznam.cz, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>
Message-ID: <20080626163832.zKq1dc6MOqFTPOiL3nJWzSGdo-H5_qPsp277tVQcCgQ@z>

On Thursday 26 June 2008, Adrian Bunk wrote:
> The comment could be nuked (as well as the #ifdef __KERNEL__), but for 
> the one #define an asm-generic header would IMHO be overkill.

I agree that it doesn't technically make sense to have a one-line
asm-generic header, but I like the idea of reducing the number of
asm/*.h files that actually contain anything other that
#include <asm-generic/$FILE.h>, mostly for documentation purposes.

If we can eventually agree on a way to get rid of the requirement
for explicit redirection, we can remove a larger number of source
files completely.

	Arnd <><
