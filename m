From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: situation with signals
Date: Wed, 27 Oct 2010 18:51:12 -0400
Message-ID: <4CC8ACE0.1040407@tilera.com>
References: <20100923221141.GK19804@ZenIV.linux.org.uk> <9lYpY1#WLHA.1516@exchange1.tad.internal.tilera.com> <4CC89352.7020808@tilera.com> <20101027213745.GI19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([72.1.168.231]:55759 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab0J0WvR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Oct 2010 18:51:17 -0400
In-Reply-To: <20101027213745.GI19804@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/27/2010 5:37 PM, Al Viro wrote:
> On Wed, Oct 27, 2010 at 05:02:10PM -0400, Chris Metcalf wrote
>> I set aside this thread to look at when I had a minute, and I believe there
>> is just one of the signal issues present in the tile code.  The fix is to
>> reset regs->fault to something other than the "syscall" fault type when
>> exiting from do_signal(), so I'll submit that up for 2.6.37 shortly.
> FWIW, I'd do that in handle_signal() when hitting a syscall restart.

Right now I'm just doing it unconditionally in handle_signal()'s caller
whether or not I actually call handle_signal, to be paranoid:

@@ -353,11 +353,11 @@
                         * clear the TS_RESTORE_SIGMASK flag.
                         */
                        current_thread_info()->status &= ~TS_RESTORE_SIGMASK;
                }

-               return;
+               goto done;
        }

        /* Did we come from a system call? */
        if (regs->faultnum == INT_SWINT_1) {
                /* Restart the system call - no handlers present */
@@ -381,10 +381,14 @@
        /* If there's no signal to deliver, just put the saved sigmask back. */
        if (current_thread_info()->status & TS_RESTORE_SIGMASK) {
                current_thread_info()->status &= ~TS_RESTORE_SIGMASK;
                sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
        }
+
+done:
+       /* Avoid double syscall restart if there are nested signals. */
+       regs->faultnum = INT_SWINT_1_SIGRETURN;
 }
 

> BTW, is everything in your pt_regs safe to modify?

What an interesting observation. :-)  In fact, it would be possible to
overwrite the privilege level (the ex1 register) from within the signal
handler and then return to run arbitrary code at kernel PL.  I'll fix it.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
