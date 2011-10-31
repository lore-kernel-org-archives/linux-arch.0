From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH RFC 8/8] tile: implement syscall restart generically
Date: Mon, 31 Oct 2011 11:48:21 -0400
Message-ID: <4EAEC345.90704@tilera.com>
References: <cover.1319364492.git.jonas@southpole.se> <e790f266cc75b291d44726cf6bf8641d1bf7af5d.1319364492.git.jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e790f266cc75b291d44726cf6bf8641d1bf7af5d.1319364492.git.jonas@southpole.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 10/23/2011 6:20 AM, Jonas Bonn wrote:
> Manipulating task state to effect re-execution of an interrupted syscall
> used to be purely architecture specific code.  However, as most arch's
> were essentially just making minor adjustments to almost identical logic,
> this code could be moved to a common implementation.
>
> The generic variant introduces the function handle_syscall_restart() to be
> called after get_signal_to_deliver().  The architecture specific register
> manipulations required to effect the actual restart are now implemented
> in the generic syscall interface found in asm/syscall.h
>
> This patch transitions this architecture's signal handling code over to
> using the generic syscall restart code by:
>
> i)  Implementing the register manipulations in asm/syscall.h
> ii) Replacing the restart logic with a call to handle_syscall_restart
>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Signed-off-by: Jonas Bonn <jonas@southpole.se>

I like the idea, though the patch isn't quite right:

- You need to move the definition of INT_SWINT_1_SIGRETURN from
<asm/sigframe.h> to <asm/syscall.h>.  You then have to add #includes of
<asm/syscall.h> to signal.c and stack.c in arch/tile/kernel.  (And probably
use syscall_clear() in signal.c.)

- In syscall_do_restartblock() you need to use regs->regs[], not regs->gprs[].

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
