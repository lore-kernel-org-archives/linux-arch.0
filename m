Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49221
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1761615AbXFDVZn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jun 2007 17:25:43 -0400
Date: Mon, 04 Jun 2007 14:25:57 -0700 (PDT)
Message-Id: <20070604.142557.68139332.davem@davemloft.net>
Subject: Re: 64-bit syscall ABI issue
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0706042051280.16431@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.0706042051280.16431@digraph.polyomino.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: joseph@codesourcery.com
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: "Joseph S. Myers" <joseph@codesourcery.com>
Date: Mon, 4 Jun 2007 20:56:57 +0000 (UTC)

[ added linux-arch which is a great place to discuss these
  kinds of issues. ]

> What should the kernel syscall ABI be in such cases (any case where the 
> syscall implementations expect arguments narrower than registers, so 
> mainly 32-bit arguments on 64-bit platforms)?  There are two obvious 
> possibilities:

In general we've taken the stance that the syscall dispatch
should create the proper calling environment for C code
implementing the system calls, and this thus means properly
sign and zero extending the arguments as expected by the C
calling convention.
