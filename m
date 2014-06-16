From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 00/11] qspinlock with paravirt support
Date: Mon, 16 Jun 2014 16:52:21 -0400
Message-ID: <20140616205221.GB26140@laptop.dumpdata.com>
References: <20140615124657.264658593@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140615124657.264658593@chello.nl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jun 15, 2014 at 02:46:57PM +0200, Peter Zijlstra wrote:
> Since Waiman seems incapable of doing simple things; here's my take on the
> paravirt crap.
> 
> The first few patches are taken from Waiman's latest series, but the virt
> support is completely new. Its primary aim is to not mess up the native code.

OK. I finally cleared some time to look over this and are reading the code
in details to make sure I have it clear in mind. I will most likely ask
some questions that are naive - hopefully they will lead to the code being
self-explanatory for anybody else taking a stab at understanding them when
bugs appear.
> 
> I've not stress tested it, but the virt and paravirt (kvm) cases boot on simple
> smp guests. I've not done Xen, but the patch should be simple and similar.

Looking forward to seeing it. Glancing over the KVM one and comparing it
to the original version that Waiman posted it should be fairly simple. Perhaps
even some of the code could be shared?

> 
> I ripped out all the unfair nonsense as its not at all required for paravirt
> and optimizations that make paravirt better at the cost of code clarity and/or
> native performance are just not worth it.
> 
> Also; if we were to ever add some of that unfair nonsense you do so _after_ you
> got the simple things working.
> 
> The thing I'm least sure about is the head tracking, I chose to do something
> different from what Waiman did, because his is O(nr_cpus) and had the
> assumption that guests have small nr_cpus. AFAIK this is not at all true. The
> biggest problem I have with what I did is that it contains wait loops itself.
> 
> 
> 
