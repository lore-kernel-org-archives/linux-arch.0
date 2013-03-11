From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: SYSV IPC broken for no-legacy syscall kernels (was Re: [RFC PATCH v1 26/31] ARC: Build system: Makefiles, Kconfig, Linker script)
Date: Mon, 11 Mar 2013 13:30:15 +0000
Message-ID: <201303111330.15589.arnd@arndb.de>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <513DD464.2060008@synopsys.com> <513DD6FB.4000400@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54384 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3CKNaU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Mar 2013 09:30:20 -0400
In-Reply-To: <513DD6FB.4000400@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Markos <markos.chandras@imgtec.com>

On Monday 11 March 2013, James Hogan wrote:
> > /*
> >  * Version flags for semctl, msgctl, and shmctl commands
> >  * These are passed as bitflags or-ed with the actual command
> >  */
> > #define IPC_OLD 0    /* Old version (no 32-bit UID support on many
> >                architectures) */
> > #define IPC_64  0x0100  /* New version (support 32-bit UIDs, bigger
> >                message sizes, etc. */
> > 
> > So someone with more ABI wisdom needs to suggest what is the right approach.
> 
> Agreed.
> 
> Note that in uClibc, 64bit arches (excl alpha/mips for some reason) were
> already defining __IPC_64 as 0, so there's some precedent for it working
> the way it does.

Yes, there is no reason to need the distinction. If LTP is checking for
IPC_OLD compatibility on anything but really old architectures, that is
a bug in LTP, or possibly in the libc.

	Arnd
