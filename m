From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: blackfin: kernel: memory overflow, 'namebuf' length
 need be more than 256
Date: Wed, 29 May 2013 18:07:02 +0800
Message-ID: <51A5D346.4010007@asianux.com>
References: <51A5CDB4.9000204@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:20990 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965230Ab3E2KHy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 06:07:54 -0400
In-Reply-To: <51A5CDB4.9000204@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>, anton.vorontsov@linaro.org, Richard Kuo <rkuo@codeaurora.org>, jesper.nilsson@axis.com
Cc: Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


The 'name' length in decode_address() may be 255, after call d_path()
successfully.

So for decode_address(), the input 'buf' need be more than 256, or may
memory overflow.

For simply thinking of, use 'namebuf[512]' instead of 'namebuf[150]'
which will pass to decode_address() as input 'buf'.

Also better use macro instead of hard code number when processing
symbols work.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/blackfin/kernel/trace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/blackfin/kernel/trace.c b/arch/blackfin/kernel/trace.c
index c36efa0..4fecd3e 100644
--- a/arch/blackfin/kernel/trace.c
+++ b/arch/blackfin/kernel/trace.c
@@ -37,7 +37,7 @@ void decode_address(char *buf, unsigned long address)
 	const char *symname;
 	char *modname;
 	char *delim = ":";
-	char namebuf[128];
+	char namebuf[KSYM_NAME_LEN];
 #endif
 
 	buf += sprintf(buf, "<0x%08lx> ", address);
@@ -845,7 +845,7 @@ void dump_bfin_mem(struct pt_regs *fp)
 
 void show_regs(struct pt_regs *fp)
 {
-	char buf[150];
+	char buf[512];
 	struct irqaction *action;
 	unsigned int i;
 	unsigned long flags = 0;
-- 
1.7.7.6
