From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] mutex: optimise generic mutex implementations
Date: Tue, 14 Oct 2008 19:35:19 +1100
Message-ID: <1223973319.8157.333.camel@pasglop>
References: <20081012054634.GA12535@wotan.suse.de>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20081012054634.GA12535@wotan.suse.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, paulus@samba.org
List-Id: linux-arch.vger.kernel.org

On Sun, 2008-10-12 at 07:46 +0200, Nick Piggin wrote:
> Speed up generic mutex implementations.
> 
> - atomic operations which both modify the variable and return something imply
>   full smp memory barriers before and after the memory operations involved
>   (failing atomic_cmpxchg, atomic_add_unless, etc don't imply a barrier because
>   they don't modify the target). See Documentation/atomic_ops.txt.
>   So remove extra barriers and branches.
>   
> - All architectures support atomic_cmpxchg. This has no relation to
>   __HAVE_ARCH_CMPXCHG. We can just take the atomic_cmpxchg path unconditionally
> 
> This reduces a simple single threaded fastpath lock+unlock test from 590 cycles
> to 203 cycles on a ppc970 system.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Looks ok.

Cheers,
Ben.
