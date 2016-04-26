From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [RFC][PATCH 22/31] locking,tile: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Tue, 26 Apr 2016 11:32:55 -0400
Message-ID: <571F8A27.1020706@mellanox.com>
References: <20160422090413.393652501@infradead.org>
 <20160422093924.482859927@infradead.org> <571E840A.8090703@mellanox.com>
 <20160426152844.GZ3448@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0095.outbound.protection.outlook.com ([157.56.112.95]:35286
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751757AbcDZPtZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Apr 2016 11:49:25 -0400
In-Reply-To: <20160426152844.GZ3448@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On 4/26/2016 11:28 AM, Peter Zijlstra wrote:
> On Mon, Apr 25, 2016 at 04:54:34PM -0400, Chris Metcalf wrote:
>> Otherwise, though just based on code inspection so far:
>>
>> Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]
> Thanks!
>
> Just to verify; the new fetch-op thingies _do_ indeed need the extra
> smp_mb() as per my patch, because there is no trailing instruction
> depending on the completion of the load?

Exactly.  I should have said so explicitly :-)

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
