Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966025AbYCSVV1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2008 17:21:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: [PATCH 7/8] x86 ptrace: arch_ptrace -ENOSYS return
In-Reply-To: Roland McGrath's message of  Wednesday, 19 March 2008 14:17:14 -0700 <20080319211714.8B14226F995@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
Message-ID: <20080319212050.32AA126F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:20:50 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>, tony.luck@intel.com, linux-ia64@vger.kernel.org
Message-ID: <20080319212050.qUVPA0yEHbjO8RWLV6OR2z7mEiwhxt7-CqKF-0p6mq0@z>

Return -ENOSYS from arch_ptrace and compat_arch_ptrace
rather than calling ptrace_request or compat_ptrace_request.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/x86/kernel/ptrace.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 777d8f9..4d5561c 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1010,7 +1010,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 #endif
 
 	default:
-		ret = ptrace_request(child, request, addr, data);
+		ret = -ENOSYS;
 		break;
 	}
 
@@ -1266,7 +1266,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		return arch_ptrace(child, request, addr, data);
 
 	default:
-		return compat_ptrace_request(child, request, addr, data);
+		ret = -ENOSYS;
+		break;
 	}
 
 	return ret;
