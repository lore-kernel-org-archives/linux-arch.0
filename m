From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Wed, 3 Apr 2019 19:16:35 +0200
Message-ID: <20190403171635.GM4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <9ec3d8dc-d1e0-1b8a-5e00-ba92b9756c58@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <9ec3d8dc-d1e0-1b8a-5e00-ba92b9756c58@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Alex Kogan <alex.kogan@oracle.com>, steven.sistare@oracle.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 03, 2019 at 12:33:20PM -0400, Waiman Long wrote:
> static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32
> val)
> {
> =A0=A0=A0=A0=A0=A0=A0 if (static_branch_unlikely(&use_numa_spinlock))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 numa_queued_spin_lock_slowp=
ath(lock, val);
> =A0=A0=A0=A0=A0=A0=A0 else=A0=A0=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 native_queued_spin_lock_slo=
wpath(lock, val);
> }

That's horrible for the exact reason you state.

> Alternatively, we can also call numa_queued_spin_lock_slowpath() in
> native_queued_spin_lock_slowpath() if we don't want to increase the code
> size of spinlock call sites.

Yeah, still don't much like that though, we're littering the fast path
of that slow path with all sorts of crap.
