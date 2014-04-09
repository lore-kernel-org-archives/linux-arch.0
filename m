From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 10/31] arch,c6x: Convert smp_mb__*
Date: Wed, 09 Apr 2014 11:35:42 -0400
Message-ID: <1397057742.31272.30.camel@deneb.redhat.com>
References: <20140319064729.660482086@infradead.org>
	 <20140319065204.317916607@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140319065204.317916607@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Wed, 2014-03-19 at 07:47 +0100, Peter Zijlstra wrote:
> c6x doesn't have a barrier.h and completely relies on
> asm-generic/barrier.h. Therefore its smp_mb() is barrier() and we can
> use the default versions that are smp_mb().
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---

Acked-by: Mark Salter <msalter@redhat.com>
