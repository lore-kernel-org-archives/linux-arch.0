Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33560 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbbIOJmE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2015 05:42:04 -0400
Received: by wiclk2 with SMTP id lk2so20215442wic.0
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2015 02:42:03 -0700 (PDT)
Date: Tue, 15 Sep 2015 12:42:00 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 04/13] Always expose MAP_UNINITIALIZED to userspace
Message-ID: <20150915094200.GA15444@node.dhcp.inet.fi>
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-5-git-send-email-palmer@dabbelt.com>
 <20150915002358.GA12618@node.dhcp.inet.fi>
 <20150915051919.GB4091@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150915051919.GB4091@x>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, arnd@arndb.de, dhowells@redhat.com, viro@zeniv.linux.org.uk, ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net, dyoung@redhat.com, drysdale@google.com, davem@davemloft.net, ebiederm@xmission.com, geoff@infradead.org, gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org, kexec@lists.infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com, x86@kernel.org
Message-ID: <20150915094200.H4qQNtdrJwAcLAQk4nRsIHWGsKqh3X3MnIB4N9MPPEs@z>

On Mon, Sep 14, 2015 at 10:19:19PM -0700, Josh Triplett wrote:
> On Tue, Sep 15, 2015 at 03:23:58AM +0300, Kirill A. Shutemov wrote:
> > On Mon, Sep 14, 2015 at 03:50:38PM -0700, Palmer Dabbelt wrote:
> > > This used to be hidden behind CONFIG_MMAP_ALLOW_UNINITIALIZED, so
> > > userspace wouldn't actually ever see it be non-zero.  While I could
> > > have kept hiding it, the man pages seem to indicate that
> > > MAP_UNINITIALIZED should be visible:
> > > 
> > >   mmap(2)
> > >   MAP_UNINITIALIZED (since Linux 2.6.33)
> > >     Don't clear anonymous pages.  This flag is intended to improve
> > >     performance on embedded devices.  This flag is honored only if the
> > >     kernel was configured with the CONFIG_MMAP_ALLOW_UNINITIALIZED
> > >     option.  Because of the security implications, that option is
> > >     normally enabled only on embedded devices (i.e., devices where one
> > >     has complete control of the contents of user memory).
> > > 
> > > and since the only time it shows up in my /usr/include is in this
> > > header I believe this should have been visible to userspace (as
> > > non-zero, which wouldn't do anything when or'd into the flags) all
> > > along.
> > 
> > Are you sure about "wouldn't do anything"?
> > Suspiciously, 0x4000000 is also (1 << MAP_HUGE_SHIFT). I'm not sure if any
> > architecture has order-1 huge pages, but still looks like we have conflict
> > here.
> > 
> > I think it's harmful to expose non-zero MAP_UNINITIALIZED to system which
> > potentially can handle multiple users. Or non-trivial user space in
> > general.
> 
> The flag should always exist.

Sure. And 0 is perfectly fine value for the flag. Like with MAP_FILE.

> If it was defined to conflict with
> something else, that's a serious ABI problem.  But the flag
> should always exist, even if the kernel ends up ignoring it.
> 
> > Should we leave it at least under '#ifndef CONFIG_MMU'? I don't think it's
> > possible to have single ABI for MMU and MMU-less systems anyway. And we
> > can avoid conflict with MAP_HUGE_SHIFT this way.
> 
> No; even if you have an MMU (which is useful for things like fork()), a
> system without user separation (for instance, without CONFIG_MULTIUSER)
> can reasonably use MAP_UNINITIALIZED.

Can? Yes. Reasonably? I don't think so.

> > P.S. MAP_UNINITIALIZED itself looks very broken to me. I probably need dig
> > mailing list on why it was allowed.
> 
> That's what the config option *and* explicit flag are for; there are
> more than enough warnings about the implications.

I think it's misdesigned. It doesn't require explicid opt-in from a
process who owned the page allocated in MAP_UNINITIALIZED mapping before.

#define MAP_LEAK_ME_SOME_DATA MAP_UNINITIALIZED

-- 
 Kirill A. Shutemov
