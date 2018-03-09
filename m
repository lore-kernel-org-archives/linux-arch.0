Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53238 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932207AbeCIOzx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Mar 2018 09:55:53 -0500
Date: Fri, 9 Mar 2018 14:55:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 0/6] arm64: untag user pointers passed to the kernel
Message-ID: <20180309145547.r25eis5ejy6d6xzu@lakrids.cambridge.arm.com>
References: <cover.1520600533.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Message-ID: <20180309145547.00ik2soCti3n3CyvnkJ-DjgZcc9owjm5bThloAgSr3w@z>

Hi,

[trimming Ccs]

On Fri, Mar 09, 2018 at 03:01:58PM +0100, Andrey Konovalov wrote:
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
> 
> This patch makes a few of the kernel interfaces accept tagged user
> pointers. The kernel is already able to handle user faults with tagged
> pointers and has the untagged_addr macro, which this patchset reuses.
> 
> We're not trying to cover all possible ways the kernel accepts user
> pointers in one patchset, so this one should be considered as a start.
> It would be nice to learn about the interfaces that I missed though.

There are many ways that user pointers can be passed to the kernel, and
I'm not sure that it's feasible to catch them all, especially as user
pointers are often passed in data structures (e.g. iovecs) rather than
direct syscall arguments.

If we *really* want the kernel to support taking tagged addresses, anything
with a __user annotation (or cast to something with a __user annotation)
requires tag removal somewhere in the kernel.

It looks like there are plenty uapi structures and syscalls to look at:

[mark@lakrids:~/src/linux]% git grep __user -- include/uapi | wc -l
216
[mark@lakrids:~/src/linux]% git grep __user | grep SYSCALL_DEFINE | wc -l
308

... in addition to special syscalls like ioctl which multiplex a number
of operations with different arguments, where the tag stripping would
have to occur elsewhere (e.g. in particular drivers).

I also wonder if we ever write any of these pointers back to userspace
memory. If so, we have a nasty ABI problem, since we'll have to marshal
the original tag along with the pointer, to ensure userspace pointer
comparisons continue to work.

Thanks,
Mark.
