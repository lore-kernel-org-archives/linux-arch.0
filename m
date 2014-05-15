From: "Joseph S. Myers" <joseph@codesourcery.com>
Subject: Re: [PATCH 00/25] Change time_t and clock_t to 64 bit
Date: Thu, 15 May 2014 18:01:37 +0000
Message-ID: <Pine.LNX.4.64.1405151748430.3155@digraph.polyomino.org.uk>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
 <8399002.IIyBoyEHox@wuerfel> <CANcMJZAOi9ctWkpEgynj6wxCrvW4oS5ZHj3Chv04D=VQDogEvw@mail.gmail.com>
 <4160991.69XaTMjMrC@wuerfel> <5374F56A.3090406@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:46040 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbaEOSBm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 May 2014 14:01:42 -0400
In-Reply-To: <5374F56A.3090406@codesourcery.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chung-Lin Tang <cltang@codesourcery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LeyFoon Tan <lftan.linux@gmail.com>

On Thu, 15 May 2014, Chung-Lin Tang wrote:

> > c) glibc may or may not provide a way for applications to use
> >    the extended interfaces without a user space ABI break. My
> >    impression so far is that this is going to be too hard and
> >    it won't be done, but this is for the glibc developers to
> >    determine.
> 
> glibc does version its exported symbols, so provided new/old syscalls
> are both provided, haveing a new version of a routine (using 64-bit
> time_t and new syscall interfaces) and the old compat routine co-exist
> should be possible. Of course, old binaries may still not be saved when
> 2038 arrives.

You could do it with symbol versioning, though my guess would be that it 
would be natural to provide _TIME_BITS like _FILE_OFFSET_BITS (with the 
combination _TIME_BITS=64, _FILE_OFFSET_BITS=32 not being supported at 
all) and then later transition the default.  (Discussion of the 
possibility of moving the default to _FILE_OFFSET_BITS=64 suggested that 
in practice most libraries in distributions where this affects the ABI are 
already built that way, though noone has followed up on that discussion to 
try to reach a consensus that we have enough evidence to change the 
default now.  There are a couple of issues with the way 
_FILE_OFFSET_BITS=64 is implemented that should be avoided in any 
implementation of _TIME_BITS=64: (a) _FILE_OFFSET_BITS=64 maps functions 
to corresponding *64 functions in the user's namespace, when it should use 
reserved-namespace names; (b) it's not a no-op for 64-bit platforms - it 
still remaps function names and types.  So _TIME_BITS=64 should only map 
to reserved-namespace names, and not do any remapping at all on platforms 
where time_t is already 64-bit.)

Obviously 64-bit time_t syscalls would be an appropriately narrow set of 
syscalls like those in the generic ABI (so glibc would implement stat for 
_TIME_BITS=64 using fstatat64_time64 or whatever the syscall is called, 
just as the stat functions for generic ABI architectures are implemented 
with newfstatat / fstatat64 rather than lots of separate syscalls.

-- 
Joseph S. Myers
joseph@codesourcery.com
