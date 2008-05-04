From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/56] microblaze_v2: Signal support
Date: Sun, 4 May 2008 21:52:06 +0200
Message-ID: <200805042152.07486.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <0674b1f7abb9a3d564b68c95bc28adc2c2fe9551.1209897266.git.monstr@monstr.eu> <9a7c6646e5dd9724c1cf34767adec181481fa3ef.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52887 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873AbYEDTwU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 15:52:20 -0400
In-Reply-To: <9a7c6646e5dd9724c1cf34767adec181481fa3ef.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> From: Michal Simek <monstr@monstr.eu>
> 
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>

This patch should have a comment saying that it will mostly go away
with the new syscall interface, with the one exception of
sys_rt_sigreturn().

	Arnd <><
