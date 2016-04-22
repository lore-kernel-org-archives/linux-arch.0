From: Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC][PATCH 02/31] locking,alpha: Implement
 atomic{,64}_fetch_{add,sub,and,andnot,or,xor}()
Date: Fri, 22 Apr 2016 09:57:04 -0700
Message-ID: <571A57E0.1040704@twiddle.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.156825130@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f66.google.com ([209.85.192.66]:36709 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbcDVQ5L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 12:57:11 -0400
In-Reply-To: <20160422093923.156825130@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On 04/22/2016 02:04 AM, Peter Zijlstra wrote:
> +	"1:	ldl_l %0,%1\n"						\
> +	"       mov %0,%2\n"						\
> +	"	" #asm_op " %0,%3,%0\n"					\
> +	"	stl_c %0,%1\n"						\

No need for the extra mov.

	ldl_l %2,%1
	asm_op %2,%3,%0
	stl_c %0,%1


r~
