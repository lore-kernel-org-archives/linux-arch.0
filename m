From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 4 Apr 2019 11:38:59 +0200
Message-ID: <20190404093859.GU4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Alex Kogan <alex.kogan@oracle.com>, Waiman Long <longman@redhat.com>, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 04, 2019 at 07:05:24AM +0200, Juergen Gross wrote:

> Without PARAVIRT_SPINLOCK this would be just an alternative() then?

That could maybe work yes. This is all early enough.

> Maybe the resulting code would be much more readable if we'd just
> make PARAVIRT_SPINLOCK usable without the other PARAVIRT hooks? So
> splitting up PARAVIRT into PARAVIRT_GUEST (timer hooks et al) and
> the patching infrastructure, with PARAVIRT_GUEST and PARAVIRT_SPINLOCK
> selecting PARAVIRT, and PARAVIRT_XXL selecting PARAVIRT_GUEST.

Well, ideally we'll get static_call() sorted and use that.
