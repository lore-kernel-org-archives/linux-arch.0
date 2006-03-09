Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from detroit.securenet-server.net ([209.51.153.26]:52150 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1030202AbWCIEST (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 23:18:19 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 20:18:04 -0800
References: <20060308184500.GA17716@devserv.devel.redhat.com> <200603081659.05786.jbarnes@virtuousgeek.org> <17423.34439.977741.295065@cargo.ozlabs.ibm.com>
In-Reply-To: <17423.34439.977741.295065@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603082018.04385.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday, March 08, 2006 5:36 pm, Paul Mackerras wrote:
> Jesse Barnes writes:
> > It uses a per-node address space to reference the local bridge. 
> > The local bridge then waits until the remote bridge has acked the
> > write before, then sets the outstanding write register to the
> > appropriate value.
>
> That sounds like mmiowb can only be used when preemption is disabled,
> such as inside a spin-locked region - is that right?

There's a scheduler hook to flush things if a process moves.  I think 
Brent Casavant submitted that patch recently.

Jesse
