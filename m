Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Feb 2005 10:21:59 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: Re: [patch] Fix shmget for ppc64, s390-64 & sparc64.
Message-ID: <20050210092159.GB15548@wotan.suse.de>
References: <26879984$1107996093420aadbd40bba6.84015745@config18.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26879984$1107996093420aadbd40bba6.84015745@config18.schlund.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, anton@samba.org, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Feb 10, 2005 at 01:44:01AM +0100, Arnd Bergmann wrote:
> 
> Andrew Morton <akpm@osdl.org> schrieb am 09.02.2005, 23:50:37:
> > Martin Schwidefsky  wrote:
> > >
> > > [patch] Fix shmget for ppc64, s390-64 & sparc64.
> > 
> > OK, but Andi's patch fixed mips and x86_64 as well, but only for
> > compat_shmget and not for sys_msgsnd and sys_msgrcv.
> 
> mips, x86_64, ia64 and parisc always got this right, they are not
> using sys_ipc in 64 bit mode. The rest is 32 bit only, so the fix
> is not needed either.

Sorry, someone is confused here.

The patch was explicitely to fix the 32bit emulation.   The problem was 
reported on x86-64 for a 32bit program. 

The 32bit emulation layer for sys_ipc() would incorrectly sign extend the
passed shared memory size when converting the argument to the native 
sys_shmget()

I think you need it even for s390 - even though you don't have more than
2GB someone could still pass a bigger size and then get the wrong
errno.

-Andi
