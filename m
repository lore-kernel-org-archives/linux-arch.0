Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:11961 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932377AbWJEW3M
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 5 Oct 2006 18:29:12 -0400
Received: from localhost.localdomain ([127.0.0.1]:41110 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039439AbWJEW3K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 5 Oct 2006 23:29:10 +0100
Date: Thu, 5 Oct 2006 23:28:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Cache alias handling in copy_user_page / copy_user_highpage
Message-ID: <20061005222834.GA19258@linux-mips.org>
References: <20060819122520.GA18180@linux-mips.org> <20060828.233656.59469351.davem@davemloft.net> <20061005165429.GA18700@linux-mips.org> <20061005.130631.63128675.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005.130631.63128675.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Oct 05, 2006 at 01:06:31PM -0700, David Miller wrote:

> > I found it to be much more maintainable to deal with this in C due to a
> > large number of processor variations to be supported.
> 
> It is a reasonable reason to use code patching :-)

In which case I guess you will enjoy arch/mips/mm/tlbex.c which is
custom tayloring TLB exception handler for the particular CPU type, errata
workaround, UP/SMP and alot of other stuff ;)

  Ralf
