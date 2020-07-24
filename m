From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/5] powerpc: Allow 4096 bytes of stack expansion for the signal frame
Date: Fri, 24 Jul 2020 19:20:18 +1000
Message-ID: <87wo2tp8vh.fsf@mpe.ellerman.id.au>
References: <20200703141327.1732550-1-mpe@ellerman.id.au> <20200703141327.1732550-2-mpe@ellerman.id.au> <87blk6tkuv.fsf@dja-thinkpad.axtens.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgGXJUZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 05:20:25 -0400
In-Reply-To: <87blk6tkuv.fsf@dja-thinkpad.axtens.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com

Daniel Axtens <dja@axtens.net> writes:
> Hi Michael,
>
> Unfortunately, this patch doesn't completely solve the problem.
>
> Trying the original reproducer, I'm still able to trigger the crash even
> with this patch, although not 100% of the time. (If I turn ASLR off
> outside of tmux it reliably crashes, if I turn ASLR off _inside_ of tmux
> it reliably succeeds; all of this is on a serial console.)
>
> ./foo 1241000 & sleep 1; killall -USR1 foo; echo ok
>
> If I add some debugging information, I see that I'm getting
> address + 4096 = 7fffffed0fa0
> gpr1 =           7fffffed1020
>
> So address + 4096 is 0x80 bytes below the 4k window. I haven't been able
> to figure out why, gdb gives me a NIP in __kernel_sigtramp_rt64 but I
> don't know what to make of that.

Thanks for testing.

I looked at it again this morning and it's fairly obvious when it's not
11pm :)

We need space for struct rt_sigframe as well as another 128 bytes,
which is __SIGNAL_FRAMESIZE. It's actually mentioned in the comment
above struct rt_sigframe.

I'll send a v2.

> P.S. I don't know what your policy on linking to kernel bugzilla is, but
> if you want:
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205183

In general I prefer to keep things clean with just a single Link: tag
pointing to the archive of the patch submission.

That can then contain further links and other info, and has the
advantage that people can reply to the patch submission in the future to
add information to the thread that wasn't known at the time of the
commit.

cheers
