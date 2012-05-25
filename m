From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 13/20] arm: Do not call try_to_freeze() in do_signal()
Date: Sat, 26 May 2012 00:43:45 +0100
Message-ID: <20120525234345.GA32000@n2100.arm.linux.org.uk>
References: <1337983476-22081-1-git-send-email-richard@nod.at> <1337983476-22081-13-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45674 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab2EYXn4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 19:43:56 -0400
Content-Disposition: inline
In-Reply-To: <1337983476-22081-13-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, May 26, 2012 at 12:04:29AM +0200, Richard Weinberger wrote:
> get_signal_to_deliver() already calls try_to_freeze(), there is no
> need to call it directly.

NAK.  Please check linux-next (okay, viro's patches haven't appeared
there yet) but a lot of this stuff is covered by a truckload of work
that Al's done.

Please don't work across Al.

commit d9be5ea6f9b6a51535ccdd9881ffb3be2dbd48e9
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Apr 27 01:18:52 2012 -0400

    arm: don't call try_to_freeze() from do_signal()
    
    get_signal_to_deliver() will handle it itself
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a6c4e78..3b37c14 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -642,9 +642,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
                }
        }
 
-       if (try_to_freeze())
-               goto no_signal;
-
        /*
         * Get the signal to deliver.  When running under ptrace, at this
         * point the debugger may change all our registers ...
@@ -684,7 +681,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
                return;
        }
 
- no_signal:
        if (syscall) {
                /*
                 * Handle restarting a different system call.  As above,
