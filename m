From: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Mon, 3 Aug 2020 16:03:59 -0400
Message-ID: <e4bf2e19-adc2-ad5e-f516-e8014500456d@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <877dufvje9.fsf@x220.int.ebiederm.org>
 <1596469370.29091.13.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:59540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgHCUEz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2020 16:04:55 -0400
In-Reply-To: <1596469370.29091.13.camel@HansenPartnership.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <willy@infradead.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On 8/3/2020 11:42 AM, James Bottomley wrote:
> On Mon, 2020-08-03 at 10:28 -0500, Eric W. Biederman wrote:
> [...]
>> What is wrong with live migration between one qemu process and
>> another qemu process on the same machine not work for this use case?
>>
>> Just reusing live migration would seem to be the simplest path of
>> all, as the code is already implemented.  Further if something goes
>> wrong with the live migration you can fallback to the existing
>> process.  With exec there is no fallback if the new version does not
>> properly support the handoff protocol of the old version.
> 
> Actually, could I ask this another way: the other patch set you sent to
> the KVM list was to snapshot the VM to a PKRAM capsule preserved across
> kexec using zero copy for extremely fast save/restore.  The original
> idea was to use this as part of a CRIU based snapshot, kexec to new
> system, restore.  However, why can't you do a local snapshot, restart
> qemu, restore using the PKRAM capsule to achieve exactly the same as
> MADV_DOEXEC does but using a system that's easy to reason about?  It
> may be slightly slower, but I think we're still talking milliseconds.

Hi James, good to hear from you.  PKRAM or SysV shm could be used for
a restart in that manner, but it would only support sriov guests if the
guest exports an agent that supports suspend-to-ram, and if all guest
drivers support the suspend-to-ram method.  I have done this using a linux
guest and qemu guest agent, and IIRC the guest pause time is 500 - 1000 msec.
With MADV_DOEXEC, pause time is 100 - 200 msec.  The pause time is a handful
of seconds if the guest uses an nvme drive because CC.SHN takes so long
to persist metadata to stable storage.

We could instead pass vfio descriptors from the old process to a 3rd party escrow 
process and pass  them back to the new qemu process, but the shm that vfio has 
already registered must be remapped at the same VA as the previous process, and 
there is no interface to guarantee that.  MAP_FIXED blows away existing mappings 
and breaks the app. MAP_FIXED_NOREPLACE respects existing mappings but cannot map 
the shm and breaks the app.  Adding a feature that reserves VAs would fix that, we 
have experimnted with one.  Fixing the vfio kernel implementation to not use the 
original VA base would also work, but I don't know how doable/difficult that would be.

Both solutions would require a qemu instance to be stopped and relaunched using shm
as guest ram, and its guest rebooted, so they do not let us update legacy 
already-running instances that use anon memory.  That problem solves itself if we 
get these rfe's into linux and qemu, and eventually users shut down the legacy
instances, but that takes years and we need to do it sooner.

- Steve
