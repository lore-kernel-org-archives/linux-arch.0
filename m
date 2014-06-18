From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/11] qspinlock: Optimize pending bit
Date: Wed, 18 Jun 2014 13:42:13 +0200
Message-ID: <53A17B15.3080904@redhat.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.638054585@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140615130153.638054585@chello.nl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Waiman.Long@hp.com, tglx@linutronix.de, mingo@kernel.org
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Il 15/06/2014 14:47, Peter Zijlstra ha scritto:
> XXX: merge into the pending bit patch..

Agree, or if not move it right after the pending bit patch, before the 
NR_CPUS optimization.

Paolo

> It is possible so observe the pending bit without the locked bit when
> the last owner has just released but the pending owner has not yet
> taken ownership.
>
> In this case we would normally queue -- because the pending bit is
> already taken. However, in this case the pending bit is guaranteed to
> be released 'soon', therefore wait for it and avoid queueing.
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
