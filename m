Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j1A9NiV8132186
	for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2005 09:23:44 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j1A9NhYg165038
	for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2005 10:23:43 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j1A9NhjD006951
	for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2005 10:23:43 +0100
In-Reply-To: <26879984$1107996093420aadbd40bba6.84015745@config18.schlund.de>
Subject: Re: Re: [patch] Fix shmget for ppc64, s390-64 & sparc64.
Message-ID: <OFFE53C2CE.5B69958C-ON41256FA4.00334B19-41256FA4.00339D35@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 10 Feb 2005 10:23:45 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, anton@samba.org, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote on 10.02.2005 01:44:01:
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

Nod. The combination of Andi's patch and mine should settle the issue.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
