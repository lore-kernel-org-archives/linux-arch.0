From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: RFC: remove the "tile" architecture from glibc
Date: Fri, 9 Mar 2018 16:53:02 +0000
Message-ID: <alpine.DEB.2.20.1803091645580.8457@digraph.polyomino.org.uk>
References: <1a57be83-3349-5450-ee4f-d2a33569a728@mellanox.com> <d6c8e425-a6b6-6594-05e3-965536f06da3@physik.fu-berlin.de> <abce89d0-6798-069a-1a54-06e664665b78@mellanox.com> <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
 <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com> <20180307181407.GA24350@alf.mars> <CAK8P3a2VuYxzy6RmL_w_5f2qHepVRhfVR5P4x9nCUYav1s5n7g@mail.gmail.com> <9a60ac70-21e4-3f48-5cd7-ffd3aabc5c21@physik.fu-berlin.de>
 <alpine.DEB.2.20.1803091622420.8457@digraph.polyomino.org.uk> <224c8996-bda1-5e75-bff3-9ed8abc4de87@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <224c8996-bda1-5e75-bff3-9ed8abc4de87@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Helmut Grohne <helmut@subdivi.de>, GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 9 Mar 2018, John Paul Adrian Glaubitz wrote:

> On 03/09/2018 05:31 PM, Joseph Myers wrote:
> > Note that SH glibc test results need some work - there are a large number 
> > of failures listed at <https://sourceware.org/glibc/wiki/Release/2.27#SH>.  
> > Probably most could be addressed with the NaN fixes I outlined at 
> > <https://sourceware.org/ml/libc-alpha/2018-02/msg00440.html> - but that 
> > does of course need someone to do the work to implement that in GCC and 
> > glibc.  (The stdlib/tst-tininess failure is stranger; SH manuals don't 
> > seem very specific on this, but the existing setting was definitely 
> > determined by testing on hardware.  SH experts with access to a range of 
> > different hardware may be needed to advise on what different hardware does 
> > or is supposed to do in this regard.)
> 
> Ok, thanks for the explanation.
> 
> On a sidenote: Is there documentation somewhere which explains how to properly
> run the glibc testsuite? I would then go ahead and run it on my Amiga 4000
> for m68k.

"make check", or "make -k check" if you're concerned about some tests 
failing to build (e.g. the compiler running out of memory on a few large 
tests) - the testsuite should continue after execution failures, but not 
after compilation failures.  (Having previously configured with 
--prefix=/usr for the build.  And if the compiler used doesn't have 
libgcc_s and libstdc++ shared libraries in directories ld.so searches by 
default, you should copy those libraries into the glibc build directory 
before running tests.)  On a system that can handle it you'd use an 
appropriate -jN option for parallelism, but probably not on m68k.

For cross testing over SSH (when glibc is running on a system that is very 
slow running the compiler or has too little memory to do so) you need a 
shared filesystem at the same path on both the system where glibc is built 
and the system where tests will execute (probably NFS-exported from the 
build system, and it may be necessary to mount it on the test system with 
acdirmax=0,acdirmin=0 to limit any caching).  Then you can pass 
test-wrapper="/path/to/glibc/scripts/cross-test-ssh.sh <host>" to make 
check.

In both cases, for very slow test systems you may wish to export 
TIMEOUTFACTOR (an integer by which all test timeouts are multiplied).

-- 
Joseph S. Myers
joseph@codesourcery.com
