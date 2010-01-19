From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: sys_recvmmsg: wire up or not?
Date: Tue, 19 Jan 2010 16:21:14 +0900
Message-ID: <20100119072114.GB16013@linux-sh.org>
References: <10f740e80912260239n17bbbd08w6c3065c12bde9c95@mail.gmail.com> <200912261212.14264.arnd@arndb.de> <1263442833.724.325.camel@pasglop> <20100113.202807.233259060.davem@davemloft.net> <1263452379.724.348.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1263452379.724.348.camel@pasglop>
Sender: linux-m68k-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, arnd@arndb.de, geert@linux-m68k.org, acme@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 14, 2010 at 05:59:39PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2010-01-13 at 20:28 -0800, David Miller wrote:
> > > Anything happening here ? We're getting that warning on ppc too
> > despite
> > > the fact that we use socketcall like x86... Should checksyscall be
> > made
> > > smarter or the syscall just removed from x86 ? :-)
> > 
> > I think it's better to trap directly to the system call rather
> > than going through yet another demultiplexer.
> > 
> > I severely regretted using sys_socketcall initially on sparc32
> > because it added a few microseconds to socket syscall latency
> > (cpus back then were slow :-) 
> 
> Oh I definitely agree that a direct syscall is better, and I wonder in
> fact if I should add new syscalls in addition to socketcall for powerpc,
> for glibc to do a slow migration :-) I was just wondering about the
> inconsistency for archs like us who have socketcall today, to also have
> to define the syscall ...
> 
> IE. I'd rather have them all duplicated into real syscalls than some of
> them only in socketcall and some on both since that will make any kind
> of userspace transition even more hellish.
> 
Presumably you're going to have to support both given that binaries with
both ABIs are going to be left around for the forseeable future. We
started out with socketcall on sh64 with the initial ABI and then
transitioned over to broken out direct system calls. While having both is
a bit inconsistent, it's not really something that can be avoided until
all of the old binaries go away. There are certainly enough architectures
today that provide both that you shouldn't really run in to any nasty
surprises at least.

32-bit SH only uses socketcall at the moment, but I'm also inclined to
add in the broken out versions and start migrating glibc over.

Unfortunately there are not a lot of good options for the syscall checker
with things like this however, given that some platforms will want one or
the other or both ;-)
