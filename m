Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:34776 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964901AbWARDiO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Jan 2006 22:38:14 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: new syscalls
Date: Wed, 18 Jan 2006 04:38:03 +0100
References: <20060117192949.625f246b.akpm@osdl.org>
In-Reply-To: <20060117192949.625f246b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601180438.03957.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 18 January 2006 04:29, Andrew Morton wrote:
> 
> Verious new syscalls which are trickling their way Linuswards and will need
> testing and wiring up once they get there:
> 
> sys_migrate_pages
> 	Merged

#define __NR_migrate_pages      256
__SYSCALL(__NR_migrate_pages, sys_migrate_pages)


We first have to wait if everybody survived crossing the 8bit boundary @)

-Andi
