Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:39757 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbXF0NgA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jun 2007 09:36:00 -0400
Received: from localhost.localdomain ([127.0.0.1]:48261 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022367AbXF0NgA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Jun 2007 14:36:00 +0100
Date: Wed, 27 Jun 2007 15:34:40 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on
	PowerPC and ARM
Message-ID: <20070627133440.GB5020@linux-mips.org>
References: <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org> <20070625103535.GF22063@parisc-linux.org> <20070625110907.GA23438@flint.arm.linux.org.uk> <1182771454.12109.71.camel@pmac.infradead.org> <20070625114742.GG22063@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070625114742.GG22063@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Woodhouse <dwmw2@infradead.org>, Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 25, 2007 at 05:47:42AM -0600, Matthew Wilcox wrote:

> Also, you might want to put something in the syscall file about signed
> vs unsigned arguments and how they behave with 32-on-64 systems.

Another fine can of worms.  On some architectures function arguments are
getting extended to full register size by the caller, on others it just
doesn't matter.  This can have very subtle effects.  MIPS belongs into the
first class which forces me to doublecheck each compat syscall entrypoint
for sign/unsigned extension issues.  Ick.

  Ralf
