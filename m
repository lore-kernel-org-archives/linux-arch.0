From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 14:32:12 +0200
Message-ID: <20170330143212.31353830@mschwideX1>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932938AbdC3Mc1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Mar 2017 08:32:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2UCNgku035562
        for <linux-arch@vger.kernel.org>; Thu, 30 Mar 2017 08:32:26 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29h1pe9bnv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Mar 2017 08:32:26 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 30 Mar 2017 13:32:22 +0100
In-Reply-To: <20170329055706.GH29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <del>

On Wed, 29 Mar 2017 06:57:06 +0100
Al Viro <viro@ZenIV.linux.org.uk> wrote:

> 	The patchset currently in vfs.git#work.uaccess is the result;
> there's more work to do, but it takes care of a large part of the
> problems.  About 2.8KLoc removed, a lot of cruft is gone and semantics
> is hopefully in sync now.  All but two architectures (ia64 and metag)
> had been switched to new mechanism; for these two I'm afraid that I'll
> need serious help from maintainers.

I have tested the code in vfs.git#work.uaccess and in principle it works
for s390. I found one bug which would return an incorrect result
for copy_from_user if the access faults on the last page of the copy.
In that case the new code would return 0 instead of the remaining bytes.

This patch snippet should fix it, please just merge it into commit
"s390: get rid of zeroing, switch to RAW_COPY_USER"

diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index b55172c..1e5bb2b 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -35,7 +35,7 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
 		"   nr    %4,%3\n"	/* %4 = (ptr + 4095) & -4096 */
 		"   slgr  %4,%1\n"
 		"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
-		"   jnh   4f\n"
+		"   jnh   5f\n"
 		"3: .insn ss,0xc80000000000,0(%4,%2),0(%1),0\n"
 		"7: slgr  %0,%4\n"
 		"   j     5f\n"

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
