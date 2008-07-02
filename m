Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.236]:3983 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194AbYGBAEI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 20:04:08 -0400
Received: by qb-out-0506.google.com with SMTP id d8so1005003qbc.37
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 17:04:04 -0700 (PDT)
From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 1/23] make section names compatible with -ffunction-sections -fdata-sections
Date: Wed, 2 Jul 2008 02:03:54 +0200
References: <200807020233.48646.vda.linux@googlemail.com> <60320.1214952973@turing-police.cc.vt.edu>
In-Reply-To: <60320.1214952973@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200807020203.54809.vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
Message-ID: <20080702000354.F-Tq2dDvvqk9mT8vp4-l3MylsQrjPxeQrAKhRt90XqM@z>

On Wednesday 02 July 2008 00:56, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 02 Jul 2008 02:33:48 +0200, Denys Vlasenko said:
> 
> > The purpose of these patches is to make kernel buildable
> > with "gcc -ffunction-sections -fdata-sections".
> > 
> > Newer gcc and binutils can do dead code and data removal
> > at link time. It is achieved using combination of
> > -ffunction-sections -fdata-sections options for gcc and
> > --gc-sections for ld.
> 
> Interesting idea.  Do you happen to have before-and-after 'size vmlinux'
> numbers to show how much space is actually reclaimed?

After this patch there will be no change - it does not do
dead code and data removal. I submitted bigger change before
but it was probably too big for digestion.

That earlier version was achieving ~10% kernel size reduction
if kernel is built without loadable module support
(loadable modules interfere with linker's dead code
and data removal, need to add some rather contrived magic
to make it work there too. Left as TODO for later).
--
vda
