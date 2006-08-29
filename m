Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:60545 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965056AbWH2QUd
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 12:20:33 -0400
Received: from localhost.localdomain ([127.0.0.1]:26771 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039484AbWH2QUc (ORCPT <rfc822;linux-arch@vger.kernel.org>
	+ 1 other); Tue, 29 Aug 2006 17:20:32 +0100
Date: Tue, 29 Aug 2006 17:20:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Why Semaphore Hardware-Dependent?
Message-ID: <20060829162055.GA31159@linux-mips.org>
References: <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, ak@suse.de, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 29, 2006 at 08:56:36AM -0700, Christoph Lameter wrote:

> > Because i386 (and x86_64) can do better by using XADDL/XADDQ.
> 
> And Ia64 would like to use fetchadd....
> 
> > CMPXCHG is not available on all archs, and may not be implemented on all archs
> > through other atomic instructions.
> 
> Which arches do not support cmpxchg?

MIPS, Alpha - probably any pure RISC load/store architecture.

  Ralf
