Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52083 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab2DJKep (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 06:34:45 -0400
Subject: Re: [PATCH v17 08/15] seccomp: add system call filtering using BPF
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <67e30a0c8655fc53a92e8138bba9de66.squirrel@webmail.greenhost.nl>
References: <1333051320-30872-1-git-send-email-wad@chromium.org>
	 <1333051320-30872-9-git-send-email-wad@chromium.org>
	 <20120406132330.457a05cf.akpm@linux-foundation.org>
	 <67e30a0c8655fc53a92e8138bba9de66.squirrel@webmail.greenhost.nl>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Apr 2012 12:34:34 +0200
Message-ID: <1334054074.3126.75.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Indan Zupancic <indan@nul.nu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, pmoore@redhat.com, corbet@lwn.net, markus@chromium.org, coreyb@linux.vnet.ibm.com, keescook@chromium.org, jmorris@namei.org
Message-ID: <20120410103434.QFw_hkuQI5mhA8B21V9pdFS38ypzT01oUAXA3cnCChk@z>

On Mon, 2012-04-09 at 04:22 +1000, Indan Zupancic wrote:
> On Sat, April 7, 2012 06:23, Andrew Morton wrote:
> >
> > I think this gives userspace an easy way of causing page allocation
> > failure warnings, by permitting large kmalloc() attempts.  Add
> > __GFP_NOWARN?
> 
> Max is 32kb. sk_attach_filter() in net/core/filter.c is worse,
> it allocates up to 512kb before even checking the length.
> 

I dont think so.

sk_attach_filter() uses sk_malloc() and it does a check.

# cat /proc/sys/net/core/optmem_max 
20480

Of course you can change the limit on your machine.



