From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Sat, 19 May 2012 07:56:30 +0000
Message-ID: <201205190756.30492.arnd@arndb.de>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <201205182158.59616.arnd@arndb.de> <4FB6C862.5060401@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52143 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab2ESH4u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 May 2012 03:56:50 -0400
In-Reply-To: <4FB6C862.5060401@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Daney <ddaney.cavm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On Friday 18 May 2012, H. Peter Anvin wrote:
> On 05/18/2012 02:58 PM, Arnd Bergmann wrote:
> > 
> > But why do you think it's wrong the way it is? I see the idea of putting
> > padding in varying places depending on the endianess as a failed experiment
> > and defining a structure that is always the same as the logical conclusion
> > from that, even if it's a bit silly to have any padding in it at all.
> > 
> 
> The *whole point* is to make the structure the same across modes, to
> make the compat layer's job easier.

I thought the point was that we could extend time_t to 64 bit at a later
point, which we already concluded isn't really happening for existing
architectures, or at least we will have bigger problems to worry about
if we do.
 
> > Being consistent seems more important here than following the intent
> > of whoever came up with the concept of the ipc64 data structures
> > and was consequently ignored by most people after him.
> 
> So you're saying because some architectures introduced a bug, we should
> CONTINUE to introduce the same bug??  WTF??

The real bug was to have a structure that is defined differently per
architecture. 

> > If we really wanted the data structures to be compatible between 32 and
> > 64 bit mode, we'd have to use __u64 here but that would mean having to
> > change all bits of user code that already rely on the existing x86
> > compatible layout.
> 
> x86 is doing it right.  Some bigendian architectures blindly copied what
> x86 was doing without thinking.  That's a bug on their part, period.

But when I did the generic header, the conclusion was that the situation
was already so much screwed up that any attempt to "fix" it would have
caused other problems:

* uclibc never incorporated the concept of per-architecture ipc header
  files, meaning it was already wrong on the few architectures that
  tried to do the right thing, but worked on those that copied from x86.
  Should we trust the next person to to a uclibc port to a new architecture
  to understand the situation fully and fix uclibc without breaking
  existing architectures?

* __kernel_time_t is not the only type that differs between 32 and 64
  bit platforms: the structures also include a __kernel_mode_t, which
  is different between 32/64 bit on at least s390, x86, arm and sparc.

* MIPS defines the data structure with padding on the correct side, but
  uses the wrong #ifdef, so all user space trying to use the definitions
  from the kernel is already broken, and the common case of little-endian
  mips32 with uclibc only works by coincidence because uclibc got it wrong
  in a different way that results in the same data structure.

* sparc, powerpc, s390, x86, mips and in fact all 32 bit architectures
  use 'unsigned long' for  msg_cbytes, sem_nsems, shm_nattch etc.
  Who cares abouto the padding for time_t when the structure is
  still incompatible and requires wrappers for 32 bit mode?

* parisc got all of the above right, but failed in two other aspects:
  according to the comment in arch/parisc/include/asm/shmbuf.h, the
  shminfo structure is defined too short for 64 bit user space, and
  at some point they managed to break all the structures for 64 bit
  mode by turning #ifdef __LP64__ into #ifdef CONFIG_64BIT. This only
  works because everybody uses 32 bit user space on parisc anyway.
  I thought we had fixed it a couple of years ago but looking at the
  code now, it's still broken.

So, given that fact that nobody ever implemented this structure correctly,
damage control was the best option available.

	Arnd
