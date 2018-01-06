From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sat, 6 Jan 2018 10:39:39 -0800
Message-ID: <20180106183937.vkseldf4arkdlkum@ast-mbp>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop>
 <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <CAPcyv4jqKmnkL1CfHVccHvocmSD4PamqOy4bPsO1789D+107FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4jqKmnkL1CfHVccHvocmSD4PamqOy4bPsO1789D+107FQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 06, 2018 at 10:29:49AM -0800, Dan Williams wrote:
> On Sat, Jan 6, 2018 at 10:13 AM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Sat, Jan 06, 2018 at 12:32:42PM +0000, Alan Cox wrote:
> >> On Fri, 5 Jan 2018 18:52:07 -0800
> >> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >>
> >> > On Fri, Jan 5, 2018 at 5:10 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >> > > From: Andi Kleen <ak@linux.intel.com>
> >> > >
> >> > > When access_ok fails we should always stop speculating.
> >> > > Add the required barriers to the x86 access_ok macro.
> >> >
> >> > Honestly, this seems completely bogus.
> >>
> >> Also for x86-64 if we are trusting that an AND with a constant won't get
> >> speculated into something else surely we can just and the address with ~(1
> >> << 63) before copying from/to user space ? The user will then just
> >> speculatively steal their own memory.
> >
> > +1
> >
> > Any type of straight line code can address variant 1.
> > Like changing:
> >   array[index]
> > into
> >   array[index & mask]
> > works even when 'mask' is a variable.
> > To proceed with speculative load from array cpu has to speculatively
> > load 'mask' from memory and speculatively do '&' alu.
> > If attacker cannot influence 'mask' the speculative value of it
> > will bound 'index & mask' value to be within array limits.
> >
> > I think "lets sprinkle lfence everywhere" approach is going to
> > cause serious performance degradation. Yet people pushing for lfence
> > didn't present any numbers.
> > Last time lfence was removed from the networking drivers via dma_rmb()
> > packet-per-second metric jumped 10-30%. lfence forces all outstanding loads
> > to complete. If any prior load is waiting on L3 or memory,
> > lfence will cause 100+ ns stall and overall kernel performance will tank.
> 
> You are conflating dma_rmb() with the limited cases where
> nospec_array_ptr() is used. I need help determining what the
> performance impact of those limited places are.

really? fdtable, access_ok, net/ipv[46] is not critical path?

> > If kernel adopts this "lfence everywhere" approach it will be
> > the end of the kernel as we know it. All high performance operations
> > will move into user space. Networking and IO will be first.
> > Since it will takes years to design new cpus and even longer
> > to upgrade all servers the industry will have no choice,
> > but to move as much logic as possible from the kernel.
> >
> > kpti already made crossing user/kernel boundary slower, but
> > kernel itself is still fast. If kernel will have lfence everywhere
> > the kernel itself will be slow.
> >
> > In that sense retpolining the kernel is not as horrible as it sounds,
> > since both user space and kernel has to be retpolined.
> 
> retpoline is variant-2, this patch series is about variant-1.

that's exactly the point. Don't slow down the kernel with lfences
to solve variant 1. retpoline for 2 is ok from long term kernel
viability perspective.
