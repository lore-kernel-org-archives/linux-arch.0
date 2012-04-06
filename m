From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v17 00/15] seccomp_filter: BPF-based syscall filtering
Date: Fri, 6 Apr 2012 14:28:46 -0700
Message-ID: <20120406142846.fd8dea70.akpm@linux-foundation.org>
References: <1333051320-30872-1-git-send-email-wad@chromium.org>
	<alpine.LRH.2.02.1203301010310.11201@tundra.namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37686 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab2DFV2t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Apr 2012 17:28:49 -0400
In-Reply-To: <alpine.LRH.2.02.1203301010310.11201@tundra.namei.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, keescook@chromium.orgOleg Nesterov <oleg@redhat.com>

On Fri, 30 Mar 2012 10:11:32 +1100 (EST)
James Morris <jmorris@namei.org> wrote:

> On Thu, 29 Mar 2012, Will Drewry wrote:
> 
> > Please see prior revisions for a detailed discussion of this patch
> > series.
> > 
> > This series is a rebase on to:
> >   b5174fa3a7f4f8f150bfa3b917c92608953dfa0f
> > with very minor changes due to rebasing and tweaks noticed by a few
> > initial users.  (I will rebase again for v3.4-rc1 when that time comes.)
> 
> I've offered to take this via my tree -- if anyone else wants to merge it 
> via theirs instead, holler.

OK by me, especially if it means that you'll carefully (re)review it!  I
had some minor quibbles with v17.

It would be good if Oleg could take a look at the signal changes, if he
has not yet done so?
