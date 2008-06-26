From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Microblaze init port v4
Date: Thu, 26 Jun 2008 17:09:36 +0200
Message-ID: <200806261709.37045.arnd@arndb.de>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:56363 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbYFZPML (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 11:12:11 -0400
In-Reply-To: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> We have there still problem with syscalls and we don't have chance to 
> fix it to stable version, this is not part which I can do yourself. 
> Microblaze will be n + 1 platform which use some old syscalls. 
> I hope you understand.

That still leaves the problem that a lot of your syscalls have bugs
copied from other platforms. If you need to maintain backwards compatibility
with your existing binaries, that's fine, but please fix the code you are
adding.

	Arnd <><
