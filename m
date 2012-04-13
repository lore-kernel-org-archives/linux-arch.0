Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tundra.namei.org ([65.99.196.166]:53493 "EHLO tundra.namei.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109Ab2DMEfH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Apr 2012 00:35:07 -0400
Date: Fri, 13 Apr 2012 14:34:00 +1000 (EST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v18 01/15] Add PR_{GET,SET}_NO_NEW_PRIVS to prevent execve
 from granting privs
In-Reply-To: <CAObL_7ER32AesD6bHk591ss0hTFmp0bjVOKV9oEdhiFwCEVOBA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1204131432430.22093@tundra.namei.org>
References: <1334267284-19166-1-git-send-email-wad@chromium.org> <alpine.LRH.2.02.1204131414580.22039@tundra.namei.org> <CAObL_7ER32AesD6bHk591ss0hTFmp0bjVOKV9oEdhiFwCEVOBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Lutomirski <luto@mit.edu>
Cc: Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, "David S. Miller" <davem@davemloft.net>, hpa@zytor.com, mingo@redhat.com, Oleg Nesterov <oleg@redhat.com>, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, Eric Paris <eparis@redhat.com>, Serge Hallyn <serge.hallyn@canonical.com>, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20120413043400.ErAcUoIYTlzso4iU2gNe1to-L39RKaSBsxH6ePt5AU8@z>

On Thu, 12 Apr 2012, Andrew Lutomirski wrote:

> > What about dynamic transitions in SELinux ?
> >
> 
> What's a dynamic transition?

The security label can be changed without an exec:

See selinux_setprocattr(), for "current".


- James
-- 
James Morris
<jmorris@namei.org>
