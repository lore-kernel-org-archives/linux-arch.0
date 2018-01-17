Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45658 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeAQLO4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jan 2018 06:14:56 -0500
Date: Wed, 17 Jan 2018 12:14:50 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] Expand the INIT_SIGNALS and INIT_SIGHAND macros and
 remove
In-Reply-To: <19929.1514903630@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.20.1801171214120.1777@nanos>
References: <alpine.DEB.2.20.1712281559410.1899@nanos> <151274828194.9961.4230316917108602662.stgit@warthog.procyon.org.uk> <151274831156.9961.11214505146256879075.stgit@warthog.procyon.org.uk> <19929.1514903630@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Message-ID: <20180117111450.9yyWtFNZlVi4oSayCD5WGCuazouk7CYmiTmfoqsPlxw@z>

On Tue, 2 Jan 2018, David Howells wrote:

> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > >  #define INIT_CPU_TIMERS(s)						\
> > ...
> > That macro is only used in init_task.c Why not moving it there and get rid
> > of the whole macro maze in the header file?
> 
> The reason I didn't get rid of it is that it's got more than one expansion
> point.  Same for INIT_PREV_CPUTIME and INIT_PID_LINK.

Ah, sorry I missed that. So yes, the current patch is fine.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
