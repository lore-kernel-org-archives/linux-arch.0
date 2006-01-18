Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:49353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964893AbWARDaE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Jan 2006 22:30:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0I3U3DZ006829
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-arch@vger.kernel.org>; Tue, 17 Jan 2006 19:30:03 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k0I3U2Iu016338
	for <linux-arch@vger.kernel.org>; Tue, 17 Jan 2006 19:30:02 -0800
Date: Tue, 17 Jan 2006 19:29:49 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: new syscalls
Message-Id: <20060117192949.625f246b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Verious new syscalls which are trickling their way Linuswards and will need
testing and wiring up once they get there:

sys_migrate_pages
	Merged

sys_openat
sys_mkdirat
sys_mknodat
sys_fchownat
sys_futimesat
sys_newfstatat
sys_unlinkat
sys_renameat
sys_linkat
sys_symlinkat
sys_readlinkat
sys_fchmodat
sys_faccessat
	Probably this week

sys_pselect6
sys_ppoll
	Probably this week

sys_unshare
	Not sure yet.  These are a bit scary and I haven't seen any
	evidence that they've had the appropriate level of review.

sys_pepoll_wait
	Just queued this in -mm.  Conceivably 2.6.16, more likely 2.6.17, or
	never.
