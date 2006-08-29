Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:38546 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965064AbWH2Q2Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 12:28:25 -0400
Date: Tue, 29 Aug 2006 09:28:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: Why Semaphore Hardware-Dependent? 
In-Reply-To: <5878.1156868702@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0608290926230.18503@schroedinger.engr.sgi.com>
References: <20060829162055.GA31159@linux-mips.org>  <44F395DE.10804@yahoo.com.au>
 <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
 <5878.1156868702@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Nick Piggin <nickpiggin@yahoo.com.au>, Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, ak@suse.de, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 29 Aug 2006, David Howells wrote:

> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > > Which arches do not support cmpxchg?
> > 
> > MIPS, Alpha - probably any pure RISC load/store architecture.
> 
> Some of these have LL/SC or equivalent instead, but ARM5 and before, FRV, M68K
> before 68020 to name but a few.

This is all pretty ancient hardware, right? And they are mostly single 
processor so no need to worry about concurrency. Just disable interrupts.

> And anything that implements CMPXCHG with spinlocks is a really bad candidate
> for CMPXCHG-based rwsems.

Those will optimize out if it is a single processor configuration.

