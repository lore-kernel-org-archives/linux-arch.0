Return-Path: <SRS0=nfbU=55=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEcS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2020 00:32:18 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C450EC0A3BE0
        for <linux-arch@vger.kernel.org>; Sun, 12 Apr 2020 21:32:18 -0700 (PDT)
Date: Sun, 12 Apr 2020 21:32:16 -0700 (PDT)
Message-ID: <20200412.213216.2171341731015449507.davem@davemloft.net>
Subject: Re: [RFC] regset ->get() API
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200222004157.GX23230@ZenIV.linux.org.uk>
References: <20200221185903.GA3929948@ZenIV.linux.org.uk>
        <20200221.112244.1426580944977593272.davem@davemloft.net>
        <20200222004157.GX23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@zeniv.linux.org.uk
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Message-ID: <20200413043216.CcR2kFTjLeIPG1-H-R_s7oeHZTQq69NwVhVnYKpXn5s@z>

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 22 Feb 2020 00:41:57 +0000

> On Fri, Feb 21, 2020 at 11:22:44AM -0800, David Miller wrote:
>> From: Al Viro <viro@zeniv.linux.org.uk>
>> Date: Fri, 21 Feb 2020 18:59:03 +0000
>> 
>> > Again, a couple of copy_regset_to_user(), but there's an additional
>> > twist - GETREGSET of 32bit task on sparc64 will use access_process_vm()
>> > when trying to fetch L0..L7/I0..I7 of other task, using copy_from_user()
>> > only when the target is equal to current.  For sparc32 this is not
>> > true - it's always copy_from_user() there, so the values it reports
>> > for those registers have nothing to do with the target process.  That
>> > part smells like a bug; by the time GETREGSET had been introduced
>> > sparc32 was not getting much attention, GETREGS worked just fine
>> > (not reporting L*/I* anyway) and for coredump it was accessing the
>> > caller's memory.  Not sure if anyone cares at that point...
>> 
>> That's definitely a bug and sparc64 is doing it correctly.
> 
> OK...  What does the comment in
>         case PTRACE_GETREGS64:
>                 ret = copy_regset_to_user(child, view, REGSET_GENERAL,
>                                           1 * sizeof(u64),
>                                           15 * sizeof(u64),
>                                           &pregs->u_regs[0]);
>                 if (!ret) {
>                         /* XXX doesn't handle 'y' register correctly XXX */
>                         ret = copy_regset_to_user(child, view, REGSET_GENERAL,
>                                                   32 * sizeof(u64),
>                                                   4 * sizeof(u64),
>                                                   &pregs->tstate);
>                 }
>                 break;   
> refer to?  The fact that you end up with 0 in pregs->y and Y in pregs->magic?
> In that case it's probably too late to do anything about that...

Yes, that's exactly what it's talking about since we have:

	unsigned int y;
	unsigned int magic;

and we're doing a 64-bit value copy.
