From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v9 00/19] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Fri, 18 Apr 2014 09:18:07 -0400
Message-ID: <20140418131807.GD4010@phenom.dumpdata.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<20140417172246.GA9849@localhost.localdomain>
	<53508474.7010402@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <53508474.7010402@hp.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Marcos Matsunaga <Marcos.Matsunaga@oracle.com>, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 17, 2014 at 09:48:36PM -0400, Waiman Long wrote:
> On 04/17/2014 01:23 PM, Konrad Rzeszutek Wilk wrote:
> >On Thu, Apr 17, 2014 at 11:03:52AM -0400, Waiman Long wrote:
> >>v8->v9:
> >>   - Integrate PeterZ's version of the queue spinlock patch with some
> >>     modification:
> >>     http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
> >>   - Break the more complex patches into smaller ones to ease review effort.
> >>   - Fix a racing condition in the PV qspinlock code.
> >I am not seeing anything mentioning that the overcommit scenario
> >for KVM and Xen had been fixed. Or was the 'racing condition' said
> >issue?
> >
> >Thanks.
> 
> The hanging is caused by a racing condition which should be fixed in
> the v9 patch. Please let me know if you are still seeing it.

OK, is there a git tree with these patches to easily slurp them up?


Thanks!
> 
> -Longman
