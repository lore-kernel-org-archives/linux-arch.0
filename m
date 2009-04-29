From: Christoph Hellwig <hch@lst.de>
Subject: Re: Fwd: arch/ && tracehook_report_syscall_xxx()
Date: Wed, 29 Apr 2009 21:44:12 +0200
Message-ID: <20090429194412.GA3306@lst.de>
References: <20090427180455.GA32509@redhat.com> <20090427182919.B923DFC3BF@magilla.sf.frob.com> <20090427183218.GA31596@lst.de> <20090429190852.GA14515@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:46948 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759738AbZD2Trx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Apr 2009 15:47:53 -0400
Content-Disposition: inline
In-Reply-To: <20090429190852.GA14515@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, chris@zankel.net, cooloney@kernel.org, deller@gmx.de, geert@linux-m68k.org, gerg@uclinux.org, hskinnemoen@atmel.com, jdike@addtoit.com, jesper.nilsson@axis.com, kyle@mcmartin.ca, linux@arm.linux.org.uk, ralf@linux-mips.org, rth@twiddle.net, starvik@axis.com, takata@linux-m32r.org, ysato@users.sourceforge.jp, zippel@linux-m68k.org, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Apr 29, 2009 at 09:08:52PM +0200, Oleg Nesterov wrote:
> . Could you please convert your syscall trace code to use
> tracehook_report_syscall_entry/tracehook_report_syscall_exit ?

This is part of Roland's step by step cookbook for new-style ptrace,
so we should have most done.  Is there anything that makes this more
urgent than the others steps for you?
