Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58245
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751054AbWDEDR6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Apr 2006 23:17:58 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1FQyVi-0001iR-58
	for linux-arch@vger.kernel.org; Tue, 04 Apr 2006 20:16:46 -0700
Date: Tue, 04 Apr 2006 20:16:33 -0700 (PDT)
Message-Id: <20060404.201633.80781445.davem@davemloft.net>
Subject: ptrace compat issue
From: "David S. Miller" <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Others may run into this too, so I'm mentioning this.

PTRACE_GETEVENTMSG writes a long into the user address space, this has
to be made an int for compat tasks.  If you get this wrong a lot of
debugging things will break, as GDB currently makes extensive use of
this facility these days.

It might be nice to try and consolidate this into a single location,
but I frankly think that's overkill and doing it in the per-arch
ptrace() syscall handler is just the easiest thing to do right now.

diff-tree acdb28098a91c930909c257da1c0837b875a11fb (from c5959ae91b2e6e93000c58d428f91c5b5b46868d)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Tue Apr 4 16:54:40 2006 -0700

    [SPARC64]: Translate PTRACE_GETEVENTMSG for 32-bit tasks.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
index c910af5..49e6ded 100644
--- a/arch/sparc64/kernel/ptrace.c
+++ b/arch/sparc64/kernel/ptrace.c
@@ -609,6 +609,22 @@ #endif
 
 	/* PTRACE_DUMPCORE unsupported... */
 
+	case PTRACE_GETEVENTMSG: {
+		int err;
+
+		if (test_thread_flag(TIF_32BIT))
+			err = put_user(child->ptrace_message,
+				       (unsigned int __user *) data);
+		else
+			err = put_user(child->ptrace_message,
+				       (unsigned long __user *) data);
+		if (err)
+			pt_error_return(regs, -err);
+		else
+			pt_succ_return(regs, 0);
+		break;
+	}
+
 	default: {
 		int err = ptrace_request(child, request, addr, data);
 		if (err)
