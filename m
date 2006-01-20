Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:64685 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbWATKFD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jan 2006 05:05:03 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: new syscalls
Date: Fri, 20 Jan 2006 10:48:25 +0100
References: <20060117192949.625f246b.akpm@osdl.org> <200601180438.03957.ak@suse.de> <20060120094309.GA9349@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060120094309.GA9349@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601201048.25554.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 20 January 2006 10:43, Heiko Carstens wrote:
> > > Verious new syscalls which are trickling their way Linuswards and will need
> > > testing and wiring up once they get there:
> > > 
> > > sys_migrate_pages
> > > 	Merged
> > 
> > #define __NR_migrate_pages      256
> > __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
> > 
> > 
> > We first have to wait if everybody survived crossing the 8bit boundary @)
> 
> Any reason why arch/x86_64/ia32/ia32entry.S has sys_futimesat in its syscall
> table instead of compat_sys_futimesat? Looks wrong to me...

Yes, seems wrong. Thanks for catching. I will submit a patch.

-Andi
