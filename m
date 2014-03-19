From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 27/31] arch,tile: Convert smp_mb__*
Date: Wed, 19 Mar 2014 13:49:59 -0400
Message-ID: <5329D8C7.3070605@tilera.com>
References: <20140319064729.660482086@infradead.org> <20140319065205.215604416@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140319065205.215604416@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On 3/19/2014 2:58 AM, Peter Zijlstra wrote:
> Implement the new smp_mb__* ops as per the old ones.
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/tile/include/asm/atomic_32.h |   10 ----------
>  arch/tile/include/asm/atomic_64.h |    6 ------
>  arch/tile/include/asm/barrier.h   |   14 ++++++++++++++
>  arch/tile/include/asm/bitops.h    |    1 +
>  arch/tile/include/asm/bitops_32.h |    8 ++------
>  arch/tile/include/asm/bitops_64.h |    4 ----
>  6 files changed, 17 insertions(+), 26 deletions(-)

Looks good, thanks.

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
