From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Tue, 4 Aug 2020 12:13:16 +0100
Message-ID: <20200804111316.GE23808@casper.infradead.org>
References: <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <877dufvje9.fsf@x220.int.ebiederm.org>
 <1596469370.29091.13.camel@HansenPartnership.com>
 <9371b8272fd84280ae40b409b260bab3@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgHDLO6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 07:14:58 -0400
Content-Disposition: inline
In-Reply-To: <9371b8272fd84280ae40b409b260bab3@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'James Bottomley' <James.Bottomley@hansenpartnership.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Steven Sistare <steven.sistare@oracle.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "arnd@arndb.de" <arnd@>

On Tue, Aug 04, 2020 at 08:44:42AM +0000, David Laight wrote:
> From: James Bottomley
> > Sent: 03 August 2020 16:43
> > 
> > On Mon, 2020-08-03 at 10:28 -0500, Eric W. Biederman wrote:
> > [...]
> > > What is wrong with live migration between one qemu process and
> > > another qemu process on the same machine not work for this use case?
> > >
> > > Just reusing live migration would seem to be the simplest path of
> > > all, as the code is already implemented.  Further if something goes
> > > wrong with the live migration you can fallback to the existing
> > > process.  With exec there is no fallback if the new version does not
> > > properly support the handoff protocol of the old version.
> > 
> > Actually, could I ask this another way: the other patch set you sent to
> > the KVM list was to snapshot the VM to a PKRAM capsule preserved across
> > kexec using zero copy for extremely fast save/restore.  The original
> > idea was to use this as part of a CRIU based snapshot, kexec to new
> > system, restore.  However, why can't you do a local snapshot, restart
> > qemu, restore using the PKRAM capsule to achieve exactly the same as
> > MADV_DOEXEC does but using a system that's easy to reason about?  It
> > may be slightly slower, but I think we're still talking milliseconds.
> 
> 
> I've had another idea (that is probably impossible...).
> What about a 'reverse mmap' operation.
> Something that creates an fd whose contents are a chunk of the
> processes address space.

http://www.wil.cx/~willy/linux/sileby.html
