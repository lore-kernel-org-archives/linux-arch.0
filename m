Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:57377 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaKEVPE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Nov 2014 16:15:04 -0500
Received: by mail-qa0-f45.google.com with SMTP id dc16so1135353qab.4
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2014 13:15:03 -0800 (PST)
From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH v5 3/7] x86: wire up preadv2 and pwritev2
Date: Wed,  5 Nov 2014 16:14:49 -0500
Message-ID: <5f9f2c090f6bcd65589816b07fdd589205e1212d.1415220890.git.milosz@adfin.com>
In-Reply-To: <cover.1415220890.git.milosz@adfin.com>
References: <cover.1415220890.git.milosz@adfin.com>
In-Reply-To: <cover.1415220890.git.milosz@adfin.com>
References: <cover.1415220890.git.milosz@adfin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-x86_64@vger.kernel.org
Message-ID: <20141105211449.uRo6-t5Y_46MRbHaoVSCCrw1bnfBUMwVDqalA2Z1PoU@z>

Signed-off-by: Milosz Tanski <milosz@adfin.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/syscalls/syscall_32.tbl | 2 ++
 arch/x86/syscalls/syscall_64.tbl | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/syscalls/syscall_32.tbl b/arch/x86/syscalls/syscall_32.tbl
index 9fe1b5d..d592d87 100644
--- a/arch/x86/syscalls/syscall_32.tbl
+++ b/arch/x86/syscalls/syscall_32.tbl
@@ -364,3 +364,5 @@
 355	i386	getrandom		sys_getrandom
 356	i386	memfd_create		sys_memfd_create
 357	i386	bpf			sys_bpf
+358	i386	preadv2			sys_preadv2
+359	i386	pwritev2		sys_pwritev2
diff --git a/arch/x86/syscalls/syscall_64.tbl b/arch/x86/syscalls/syscall_64.tbl
index 281150b..7be2447 100644
--- a/arch/x86/syscalls/syscall_64.tbl
+++ b/arch/x86/syscalls/syscall_64.tbl
@@ -328,6 +328,8 @@
 319	common	memfd_create		sys_memfd_create
 320	common	kexec_file_load		sys_kexec_file_load
 321	common	bpf			sys_bpf
+322	64	preadv2			sys_preadv2
+323	64	pwritev2		sys_pwritev2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
1.9.1

