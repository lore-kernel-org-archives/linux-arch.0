Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49726 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756381AbYDVNPl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 09:15:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 15:15:26 +0200
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
In-Reply-To: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200804221515.28075.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, monstr@seznam.cz, git@xilinx.com, microblaze-uclinux@itee.uq.edu.au
Message-ID: <20080422131526.hLbEfGRv29Ls_LtmN0ifkpLe4C7oG7rCWGBqLI7HKy8@z>

On Tuesday 22 April 2008, Will Newton wrote:
> This patch introduces a __ARCH_WANT_SYS_SYSFS #define for
> architectures that support the sysfs(2) system call. At the moment
> that's everybody but blackfin, but future architectures may want to
> save the (admittedly small) code size that it adds to the kernel as
> well.

Yes, good thing to have. Since we'll be getting a new architecture
(microblaze) soon, I think we should extend this mechanism (even though
it's ugly) to all syscalls that we don't want to have in new architectures
and make sure that microblaze doesn't have to set any of them.

	Arnd <><
