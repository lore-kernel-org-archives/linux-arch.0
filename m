From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Wed, 3 Apr 2019 18:10:03 +0200
Message-ID: <20190403161003.GL4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <20190401090653.GF11158@hirez.programming.kicks-ass.net>
 <20190401093345.GA14281@hirez.programming.kicks-ass.net>
 <7A8A6827-BF79-47FC-99A1-C9EE00D9C3B1@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <7A8A6827-BF79-47FC-99A1-C9EE00D9C3B1@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 03, 2019 at 11:53:53AM -0400, Alex Kogan wrote:

> > One thing we could maybe do is change locked and count to u8, then your
> > overlay structure could be something like:
> > 
> > struct mcs_spinlock {
> > 	struct mcs_spinlock *next;
> > 	u8 locked;
> > 	u8 count;
> > };
> I was trying to keep the size of the mcs_spinlock structure for the non-NUMA variant unchanged.
> If this is not a huge concern, changing the fields as above would indeed simplify a few things.

Well, sizeof(struct mcs_spinlock) is unchanged by the above proposal
(for x86_64).

And I don't think it matters for x86, which is very good at byte
accesses, my only concern would be for other architectures that might
not be as good at byte accesses. For instance Alpha <EV56 would generate
shit code, but then, Alpha isn't using qspinlock anyway.
