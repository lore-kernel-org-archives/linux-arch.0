From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6] improve sys_personality for compat architectures
Date: Thu, 4 Feb 2010 08:38:10 +0100
Message-ID: <201002040838.10783.arnd@arndb.de>
References: <201002021536.51928.arnd@arndb.de> <20100203.091309.52886984.davem@davemloft.net> <4B69D6BA.4030704@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53277 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0BDHlc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2010 02:41:32 -0500
In-Reply-To: <4B69D6BA.4030704@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Miller <davem@davemloft.net>, hch@lst.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tony.luck@intel.com, ralf@linux-mips.org, kyle@mcmartin.ca, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tglx@linutronix.de, mingo@redhat.com, viro@zeniv.linux.org.uk

On Wednesday 03 February 2010, H. Peter Anvin wrote:
> The x86 method of simply not bothering doesn't seem to have caused
> problems -- our compat (and noncompat) tasks happily return PER_LINUX32
> if that is the mode and we don't seem to have had complaints with it.
> If userspace ever had an issue with it -- and they might have, at one
> point in history libc used to call personality() during startup, which
> it doesn't seem to anymore -- they presumably have worked through it.
> 
> As such, I'm more than a little reluctant to change the current behavior.

I think it would be better to have a consistent behavior across
architectures, so /something/ should be changed. On x86, the unused
sys32_personality function can probable just be removed, if nothing
else.

If we can get everyone to agree with the x86 way of handling this,
we can also remove all the special cases for sys32_personality in the
other architectures.

	Arnd
