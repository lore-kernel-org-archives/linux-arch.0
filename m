From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Making a universal list of syscalls?
Date: Tue, 04 Mar 2014 11:27:35 -0800
Message-ID: <53162927.4040401@zytor.com>
References: <CALCETrWbjazg_kAY1uAB+cMTdaJqtyGrTwQWNFCSzZ56B0KEkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrWbjazg_kAY1uAB+cMTdaJqtyGrTwQWNFCSzZ56B0KEkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, libseccomp-discuss@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

On 02/27/2014 12:40 PM, Andy Lutomirski wrote:
> Currently, dealing with Linux syscalls in an architecture-independent
> way is a mess.  Here are some issues:
> 
>  1. There's no clean way to map between syscall names and numbers on
> different architectures.  The kernel contains a number of tables (that
> work differently for different architectures).  strace has some arcane
> mechanism.  libseccomp has another.
> 
>  2. There's no clean way to map between syscall argument registers and
> logical syscall arguments.  Each architecture knows how to do it, as
> do strace and glibc, but I suspect that *everyone* else gets it wrong.
>  Especially on ARM.
> 
>  3. Determining which architectures have which syscalls is a mess.
> Recent kernel builds love to warn me that finit_module is missing on
> x86_64.  This is simply not true.  I have no idea why.
> 
>  4. Actually issuing a nontrivial syscall is annoying.  syscall(2) can
> do it for the native architecture (only).
> 
>  5. Decoding ucontext from SIGSYS is a mess.  I have prototype code
> for libseccomp that can do it, but it gets the arguments wrong due to
> ABI issues.  See (2).
> 
> I'd like to see a master list in the kernel that lists, for every
> syscall, the name, the number for each architecture that implements it
> (using the AUDIT_ARCH semantics, probably), and the signature.  The
> build process could parse this table to replace the current per-arch
> mess.
> 

Hi Andy,

I have brought that up a lot of times, originally dating back from my
work on klibc.  I have tried to keep the klibc syscall list in a sane
format with architecture annotations, but it doesn't contain all the
syscalls in the system.

Extending that work and making it encompass everything the kernel
exports would be highly useful, but it would take a lot of work.

	-hpa
