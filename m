From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 0/8] qspinlock: a 4-byte queue spinlock with PV support
Date: Fri, 28 Feb 2014 11:56:14 -0500
Message-ID: <5310BFAE.1080003@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<20140226170041.GA20775@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140226170041.GA20775@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Marcos Matsunaga <Marcos.Matsunaga@oracle.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/26/2014 12:00 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Feb 26, 2014 at 10:14:20AM -0500, Waiman Long wrote:
> It should be fairly easy. You just need to implement the kick right?
> An IPI should be all that is needed - look in xen_unlock_kick. The
> rest of the spinlock code is all generic that is shared between
> KVM, Xen and baremetal.
>
> You should be able to run all of this under an HVM guests as well - as
> in you don't need a pure PV guest to use the PV ticketlocks.
>
> An easy way to install/run this is to install your latest distro,
> do 'yum install xen' or 'apt-get install xen'. Reboot and you
> are under Xen. Launch guests, etc with your favorite virtualization
> toolstack.

Thank for the tip. I will try that out.

-Longman
