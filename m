From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 17/35] Make asm-generic/cmpxchg.h #include
 asm-generic/cmpxchg-local.h [ver #2]
Date: Wed, 14 Mar 2012 18:36:47 +0100
Message-ID: <1331746607.5104.93.camel@jerome.southpole.se>
References: <1331738610.5104.84.camel@jerome.southpole.se>
	<1331736182.5104.74.camel@jerome.southpole.se>
	<CACM3HyHaFqVBaALMNB9dTE+7JrT1qD0jrYtV2PzwTskv8sW4Hg@mail.gmail.com>
	<20120312233602.13888.27659.stgit@warthog.procyon.org.uk>
	<20120312233858.13888.34822.stgit@warthog.procyon.org.uk>
	<201203130900.41993.arnd@arndb.de> <11556.1331723400@redhat.com>
	<18016.1331738258@redhat.com>  <21309.1331744879@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <21309.1331744879@redhat.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux@openrisc.net, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org


On Wed, 2012-03-14 at 17:07 +0000, David Howells wrote:
> Jonas Bonn <jonas@southpole.se> wrote:
> 
> > > > The error I get while building (if asm/system.h is included) is a
> > > > circular dependency that I don't see that I can easily resolve:
> > > 
> > > How do I get an openrisc toolchain?
> > 
> > http://openrisc.net/toolchain-build.html
> > 
> > What distro are you on?  I might be able to send you a binary version if
> > you prefer...
> 
> I'd like to add it to my spec file to build the complete clutch of binutils
> and gcc RPMs for Fedora.
> 
> I originally tried --target=openrisc-elf, but whilst that is supported by
> binutils, it doesn't seem to be supported by gcc.
> 

That openrisc-elf target in upstream binutils is ancient and has not
worked for years... it really should be pulled out of binutils
altogether.  The current toolchain bits are unfortunately not part of
the upstream toolchain components.

> According to your URL above, I should be using --target=or32-linux, but
> binutils claims not to support that:
> 
> 	*** ld does not support target or32-unknown-linux-gnu
> 

or32-linux is supported in the toolchain from openrisc.net.  Likewise
or32-elf... follow the instructions (the easy ones should work) on the
link I sent you -- the submodules in the "toolchain" repo are from the
openrisc git repo and contain everything that is needed.

/Jonas
