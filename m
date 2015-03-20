From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] qspinlock, x86,
	kvm: Implement KVM support for paravirt qspinlock
Date: Fri, 20 Mar 2015 13:13:56 +0530
Message-ID: <550BCFBC.9000106@linux.vnet.ibm.com>
References: <20150316131613.720617163@infradead.org>
	<20150316133112.333845162@infradead.org> <550A3863.2060808@hp.com>
	<20150319100121.GL21418@twins.programming.kicks-ass.net>
	<550B3ACF.4050908@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <550B3ACF.4050908@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>, scott.norton@hp.com, x86@kernel.org, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

On 03/20/2015 02:38 AM, Waiman Long wrote:
> On 03/19/2015 06:01 AM, Peter Zijlstra wrote:
[...]
> You are probably right. The initial apply_paravirt() was done before the
> SMP boot. Subsequent ones were at kernel module load time. I put a
> counter in the __native_queue_spin_unlock() and it registered 26949
> unlock calls in a 16-cpu guest before it got patched out.

because even printks take lock..
