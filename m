From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/11] qspinlock: Extract out the exchange of tail code
	word
Date: Wed, 18 Jun 2014 17:49:52 +0200
Message-ID: <53A1B520.6090902@redhat.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.376621956@chello.nl>
	<20140617205525.GB29634@laptop.dumpdata.com>
	<53A17A09.6010007@redhat.com>
	<20140618135057.GB4729@laptop.dumpdata.com>
	<53A1B43C.8000009@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53A1B43C.8000009@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm@vger.kernel.org, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, gleb@redhat.com, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Il 18/06/2014 17:46, Waiman Long ha scritto:
>>
>>
>> The #1 patch is nice by itself - as it lays out the foundation of the
>> MCS-similar code - and if Ingo decides he does not want this pending
>> byte-lock bit business - it can be easily reverted or dropped.
>
> The pending bit code is needed for performance parity with ticket
> spinlock for light load. My own measurement indicates that the queuing
> overhead will cause the queue spinlock to be slower than ticket spinlock
> with 2-4 contending tasks. The pending bit solves the performance
> problem with 2 contending tasks, leave only the 3-4 tasks cases being a
> bit slower than the ticket spinlock which should be more than
> compensated by its superior performance with heavy contention and
> slightly better performance with no contention.

Note that this patch is not related to the pending bit, only to the 
trylock bit which is already in patch 1.  It serializes two 
previously-parallel checks for transitions.  This is why I thought it 
could already belong in patch 1.

Paolo
