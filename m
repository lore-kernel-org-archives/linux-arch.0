From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Xen-devel] [PATCH 0/9] qspinlock stuff -v15
Date: Thu, 19 Mar 2015 19:32:20 +0100
Message-ID: <20150319183220.GU23123@twins.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
	<550B0EFE.1040309@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <550B0EFE.1040309@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, oleg@redhat.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, doug.hatch@hp.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 19, 2015 at 06:01:34PM +0000, David Vrabel wrote:
> This seems work for me, but I've not got time to give it a more thorough
> testing.
> 
> You can fold this into your series.

Thanks!

> There doesn't seem to be a way to disable QUEUE_SPINLOCKS when supported by
> the arch, is this intentional?  If so, the existing ticketlock code could go.

Yeah, its left as a rudiment such that if we find issues with the
qspinlock code we can 'revert' with a trivial patch. If no issues show
up we can rip out all the old code in a subsequent release.
