Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:32805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbdL1PEg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Dec 2017 10:04:36 -0500
Date: Thu, 28 Dec 2017 16:04:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] Expand the INIT_SIGNALS and INIT_SIGHAND macros and
 remove
In-Reply-To: <151274831156.9961.11214505146256879075.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.20.1712281559410.1899@nanos>
References: <151274828194.9961.4230316917108602662.stgit@warthog.procyon.org.uk> <151274831156.9961.11214505146256879075.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Message-ID: <20171228150431.gsGQVR1nOE4btEBhVuchM0iQDHESovivTxFbbI6Uczg@z>

On Fri, 8 Dec 2017, David Howells wrote:
>  #define INIT_CPU_TIMERS(s)						\
>  	.cpu_timers = {							\
>  		LIST_HEAD_INIT(s.cpu_timers[0]),			\
>  		LIST_HEAD_INIT(s.cpu_timers[1]),			\

That macro is only used in init_task.c Why not moving it there and get rid
of the whole macro maze in the header file?

Thanks,

	tglx
