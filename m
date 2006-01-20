Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:54705 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750765AbWATJoP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jan 2006 04:44:15 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id k0K9hdln178140
	for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2006 09:43:43 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0K9hG8Q199934
	for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2006 10:43:16 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id k0K9hGKY032296
	for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2006 10:43:16 +0100
Date: Fri, 20 Jan 2006 10:43:09 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: new syscalls
Message-ID: <20060120094309.GA9349@osiris.boeblingen.de.ibm.com>
References: <20060117192949.625f246b.akpm@osdl.org> <200601180438.03957.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601180438.03957.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> > Verious new syscalls which are trickling their way Linuswards and will need
> > testing and wiring up once they get there:
> > 
> > sys_migrate_pages
> > 	Merged
> 
> #define __NR_migrate_pages      256
> __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
> 
> 
> We first have to wait if everybody survived crossing the 8bit boundary @)

Any reason why arch/x86_64/ia32/ia32entry.S has sys_futimesat in its syscall
table instead of compat_sys_futimesat? Looks wrong to me...

Thanks,
Heiko
