Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268501AbUJTQ05@vger.kernel.org>
Received: from stat16.steeleye.com ([209.192.50.48]:45993 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268490AbUJTQZw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 12:25:52 -0400
Subject: Re: 4level page tables architecture porting
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <200410201706.00435.arnd@arndb.de>
References: <20041020131340.GA5282@mschwid3.boeblingen.de.ibm.com>
	<20041020143949.GB32257@wotan.suse.de>  <200410201706.00435.arnd@arndb.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 20 Oct 2004 11:25:35 -0500
Message-Id: <1098289545.2009.17.camel@mulgrave>
Mime-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-10-20 at 10:05, Arnd Bergmann wrote:
> Doesn't that mean spending another page for each running process? I would
> rather like to see a way to use a dynamic page table layout, where 32 bit
> tasks always use only two level page tables, while 64 bit tasks start
> with two or three levels and then go to four or five levels when users
> map files that don't fit in.

Actually, the kicker (at least for software TLB architectures) is
another lookup in the TLB insertion handler.  We actually run a hybrid
scheme on parisc for this reason---compat 32 processes only get a
2-Level page table even on 64 bit kernels.  That was also the reason for
all the theoretical work on different types of page tables.

James
