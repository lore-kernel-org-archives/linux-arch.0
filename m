Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:60092 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965148AbWH2Qxk
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 12:53:40 -0400
Received: from localhost.localdomain ([127.0.0.1]:57826 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039487AbWH2Qxk (ORCPT <rfc822;linux-arch@vger.kernel.org>
	+ 1 other); Tue, 29 Aug 2006 17:53:40 +0100
Date: Tue, 29 Aug 2006 17:53:52 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Why Semaphore Hardware-Dependent?
Message-ID: <20060829165352.GA20453@linux-mips.org>
References: <20060829162055.GA31159@linux-mips.org> <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com> <5878.1156868702@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5878.1156868702@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, ak@suse.de, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 29, 2006 at 05:25:02PM +0100, David Howells wrote:

> Some of these have LL/SC or equivalent instead, but ARM5 and before, FRV, M68K
> before 68020 to name but a few.

68k before 68020 isn't supported by Linux anyway.

  Ralf
