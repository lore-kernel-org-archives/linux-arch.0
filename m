From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 05/27] xen, cpu hotplug: Don't call
	cpu_bringup() in xen_play_dead()
Date: Tue, 5 Jun 2012 12:49:57 -0400
Message-ID: <20120605164957.GA1997@phenom.dumpdata.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
	<20120601091124.31979.91984.stgit@srivatsabhat.in.ibm.com>
	<4FC8D8E30200007800087D2B@nat28.tlf.novell.com>
	<4FC8DC19.4000007@linux.vnet.ibm.com>
	<4FC8FD9C0200007800087DF5@nat28.tlf.novell.com>
	<4FCA5608.2010404@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FCA5608.2010404@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, akpm@linux-foundation.org, nikunj@linux.vnet.ibm.com, peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org, vatsa@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, rjw@sisk.pl, yong.zhang0@gmail.com, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Keir Fraser <keir@xen.org>, Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Jun 02, 2012 at 11:36:00PM +0530, Srivatsa S. Bhat wrote:
> On 06/01/2012 09:06 PM, Jan Beulich wrote:
> 
> >>>> On 01.06.12 at 17:13, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> > wrote:
> >> On 06/01/2012 06:29 PM, Jan Beulich wrote:
> >>
> >>>>>> On 01.06.12 at 11:11, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> >>> wrote:
> >>>> xen_play_dead calls cpu_bringup() which looks weird, because xen_play_dead()
> >>>> is invoked in the cpu down path, whereas cpu_bringup() (as the name 
> >>>> suggests) is useful in the cpu bringup path.
> >>>
> >>> This might not be correct - the code as it is without this change is
> >>> safe even when the vCPU gets onlined back later by an external
> >>> entity (e.g. the Xen tool stack), and it would in that case resume
> >>> at the return point of the VCPUOP_down hypercall. That might
> >>> be a heritage from the original XenoLinux tree though, and be
> >>> meaningless in pv-ops context - Jeremy, Konrad?
> >>>
> >>> Possibly it was bogus/unused even in that original tree - Keir?
> >>>
> >>
> >>
> >> Thanks for your comments Jan!
> >>
> >> In case this change is wrong, the other method I had in mind was to call
> >> cpu_bringup_and_idle() in xen_play_dead(). (Even ARM does something similar,
> >> in the sense that it runs the cpu bringup code including cpu_idle(), in the
> >> cpu offline path, namely the cpu_die() function). Would that approach work
> >> for xen as well? If yes, then we wouldn't have any issues to convert xen to
> >> generic code.
> > 
> > No, that wouldn't work either afaict - the function is expected
> > to return.
> > 
> 
> 
> Ok.. So, I would love to hear a confirmation about whether this patch (which
> removes cpu_bringup() in xen_play_dead()) will break things or it is good as is.

I think it will break - are these patches available on some git tree to test them out?

> 
> If its not correct, then we can probably make __cpu_post_online() return an int,
> with the meaning:
> 
> 0 => success, go ahead and call cpu_idle()
> non-zero => stop here, thanks for your services so far.. now leave the rest to me.
> 
> So all other archs will return 0, Xen will return non-zero, and it will handle
> when to call cpu_idle() and when not to do so.

The call-chain (this is taken from 41bd956de3dfdc3a43708fe2e0c8096c69064a1e):

    cpu_bringup_and_idle:
     \- cpu_bringup
      |   \-[preempt_disable]
      |
      |- cpu_idle
           \- play_dead [assuming the user offlined the VCPU]
           |     \
           |     +- (xen_play_dead)
           |          \- HYPERVISOR_VCPU_off [so VCPU is dead, once user
           |          |                       onlines it starts from here]
           |          \- cpu_bringup [preempt_disable]
           |
           +- preempt_enable_no_reschedule()
           +- schedule()
           \- preempt_enable()

Which I think is a bit different from your use-case?

> 
> Might sound a bit ugly, but I don't see much other option. Suggestions are
> appreciated!
> 
> Regards,
> Srivatsa S. Bhat
