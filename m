Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: =?iso-8859-1?Q?Re:_Re:_[patch]_Fix_shmget_for_ppc64,_s390-64_&_sparc64=2E?=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Message-Id: <26879984$1107996093420aadbd40bba6.84015745@config18.schlund.de>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Thu, 10 Feb 2005 01:44:01 +0100
To: =?iso-8859-1?Q?Andrew_Morton?= <akpm@osdl.org>
Cc: =?iso-8859-1?Q?Martin_Schwidefsky?= <schwidefsky@de.ibm.com>, anton@samba.org, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Andrew Morton <akpm@osdl.org> schrieb am 09.02.2005, 23:50:37:
> Martin Schwidefsky  wrote:
> >
> > [patch] Fix shmget for ppc64, s390-64 & sparc64.
> 
> OK, but Andi's patch fixed mips and x86_64 as well, but only for
> compat_shmget and not for sys_msgsnd and sys_msgrcv.

mips, x86_64, ia64 and parisc always got this right, they are not
using sys_ipc in 64 bit mode. The rest is 32 bit only, so the fix
is not needed either.

       Arnd <><
