From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 00/19] qspinlock: a 4-byte queue spinlock
	with PV support
Date: Thu, 17 Apr 2014 23:10:28 +0530
Message-ID: <5350120C.40607@linux.vnet.ibm.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<20140417172246.GA9849@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20140417172246.GA9849@localhost.localdomain>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Waiman Long <Waiman.Long@hp.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On 04/17/2014 10:53 PM, Konrad Rzeszutek Wilk wrote:
> On Thu, Apr 17, 2014 at 11:03:52AM -0400, Waiman Long wrote:
>> v8->v9:
>>    - Integrate PeterZ's version of the queue spinlock patch with some
>>      modification:
>>      http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
>>    - Break the more complex patches into smaller ones to ease review effort.
>>    - Fix a racing condition in the PV qspinlock code.
>
> I am not seeing anything mentioning that the overcommit scenario
> for KVM and Xen had been fixed. Or was the 'racing condition' said
> issue?

Saw changes in patch 18 that fixes for kvm (19 for xen). 'll
test the series and confirm.
