Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36535 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933710AbbCPS1Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2015 14:27:25 -0400
Received: by igbue6 with SMTP id ue6so49905408igb.1
        for <linux-arch@vger.kernel.org>; Mon, 16 Mar 2015 11:27:24 -0700 (PDT)
From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH v7 3/5] x86: wire up preadv2 and pwritev2
Date: Mon, 16 Mar 2015 14:27:13 -0400
Message-ID: <18a9557048c5f8b66d0cbcc54a31b95af5dfcfac.1426528417.git.milosz@adfin.com>
In-Reply-To: <cover.1426528417.git.milosz@adfin.com>
References: <cover.1426528417.git.milosz@adfin.com>
In-Reply-To: <cover.1426528417.git.milosz@adfin.com>
References: <cover.1426528417.git.milosz@adfin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20150316182713.EV3IavagYJ5JR3JmvTNvfwwi0IdP10T8uAwD4RQjPqs@z>

Signed-off-by: Milosz Tanski <milosz@adfin.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/syscalls/syscall_32.tbl | 2 ++
 arch/x86/syscalls/syscall_64.tbl | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/syscalls/syscall_32.tbl b/arch/x86/syscalls/syscall_32.tbl
index b3560ec..b37aa9c 100644
--- a/arch/x86/syscalls/syscall_32.tbl
+++ b/arch/x86/syscalls/syscall_32.tbl
@@ -365,3 +365,5 @@
 356	i386	memfd_create		sys_memfd_create
 357	i386	bpf			sys_bpf
 358	i386	execveat		sys_execveat			stub32_execveat
+359	i386	preadv2			sys_preadv2
+360	i386	pwritev2		sys_pwritev2
diff --git a/arch/x86/syscalls/syscall_64.tbl b/arch/x86/syscalls/syscall_64.tbl
index 8d656fb..3802ebf 100644
--- a/arch/x86/syscalls/syscall_64.tbl
+++ b/arch/x86/syscalls/syscall_64.tbl
@@ -329,6 +329,8 @@
 320	common	kexec_file_load		sys_kexec_file_load
 321	common	bpf			sys_bpf
 322	64	execveat		stub_execveat
+323	64	preadv2			sys_preadv2
+324	64	pwritev2		sys_pwritev2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
1.9.1

