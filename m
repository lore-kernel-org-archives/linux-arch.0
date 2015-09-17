Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbbIQKNs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Sep 2015 06:13:48 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20150915140742.GA11938@x>
References: <20150915140742.GA11938@x> <1441832902-28993-1-git-send-email-palmer@dabbelt.com> <1442271047-4908-1-git-send-email-palmer@dabbelt.com> <1442271047-4908-5-git-send-email-palmer@dabbelt.com> <20150915002358.GA12618@node.dhcp.inet.fi> <20150915051919.GB4091@x> <20150915094200.GA15444@node.dhcp.inet.fi>
Subject: Re: [PATCH 04/13] Always expose MAP_UNINITIALIZED to userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16168.1442484811.1@warthog.procyon.org.uk>
Date: Thu, 17 Sep 2015 11:13:31 +0100
Message-ID: <16169.1442484811@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: dhowells@redhat.com, "Kirill A. Shutemov" <kirill@shutemov.name>, Palmer Dabbelt <palmer@dabbelt.com>, arnd@arndb.de, viro@zeniv.linux.org.uk, ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net, dyoung@redhat.com, drysdale@google.com, davem@davemloft.net, ebiederm@xmission.com, geoff@infradead.org, gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org, kexec@lists.infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com, x86@kernel.org
Message-ID: <20150917101331.1isDnxLurV5JpqbSuJyz8FgFy6YQ-USxtgzLtMIRuPk@z>

Josh Triplett <josh@joshtriplett.org> wrote:

> > Sure. And 0 is perfectly fine value for the flag. Like with MAP_FILE.
> 
> Rephrasing: the flag should always exist with the correct value.
> Whether the kernel handles it or not, the kernel *headers* shouldn't
> change to match the kernel, not least of which because they don't
> necessarily match the running kernel.  Just like we define the
> prototypes for syscalls that the running kernel may return ENOSYS for.

Josh is correct.

CONFIG_xxx *should* *not* be seen in UAPI headers, except inside #ifdef
__KERNEL__ guards under special circumstances - and #ifdef __KERNEL__ guards
*should* *not* be seen in UAPI headers except under special circumstances.

In terms of such special circumstances, take a peek in
include/uapi/linux/acct.h at struct acct with this:

	/* m68k had no padding here. */
	#if !defined(CONFIG_M68K) || !defined(__KERNEL__)
		__u16		ac_ahz;			/* AHZ */
	#endif

in the middle of it...

Or include/{,uapi/}linux/agpgart.h where it defines two different but
same-named variants of several structs.

Now, some of these - particularly things like the latter - can be fixed by
someone who has the time.

David
