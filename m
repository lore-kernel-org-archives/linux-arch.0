From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 02/31] x86: Make sure free_init_pages() free pages in
 boundary
Date: Mon, 29 Mar 2010 18:57:06 +0200
Message-ID: <20100329165706.GA13961@elte.hu>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org>
 <1269830604-26214-3-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51638 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055Ab0C2Q6K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Mar 2010 12:58:10 -0400
Content-Disposition: inline
In-Reply-To: <1269830604-26214-3-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


Note, i applied the fix below, without it the 32-bit defconfig build would 
fail with:

 arch/x86/kernel/head32.c: In function 'i386_start_kernel':
 arch/x86/kernel/head32.c:50: error: implicit declaration of function 'PAGE_ALIGN'

	Ingo

Index: linux/arch/x86/kernel/head32.c
===================================================================
--- linux.orig/arch/x86/kernel/head32.c
+++ linux/arch/x86/kernel/head32.c
@@ -7,6 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/start_kernel.h>
+#include <linux/mm.h>
 
 #include <asm/setup.h>
 #include <asm/sections.h>
