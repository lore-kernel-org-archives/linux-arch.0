Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43013 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfEaTX4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 15:23:56 -0400
Received: by mail-pf1-f169.google.com with SMTP id c6so6766478pfa.10
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 12:23:56 -0700 (PDT)
Subject: [PATCH 5/5] x86: Add fchmod4 to syscall_32.tbl
Date: Fri, 31 May 2019 12:12:04 -0700
Message-ID: <20190531191204.4044-6-palmer@sifive.com>
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20190531191204.QXtsoDDSBX5Zm2efusFDzmJYpxYQVRwVqFdC9FRp_jc@z>

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 1f9607ed087c..319c7a6d3f02 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -433,3 +433,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	fchmodat4		sys_fchmodat4			__ia32_sys_fchmodat4
-- 
2.21.0
