From: "Maciej W. Rozycki" <macro@codesourcery.com>
Subject: Re: [PATCH 3/5] mips: sanitize restart logics
Date: Sat, 16 Oct 2010 01:25:45 +0100 (BST)
Message-ID: <alpine.DEB.1.10.1010160121080.25860@tp.orcam.me.uk>
References: <E1P0eK5-0006j5-4q@ZenIV.linux.org.uk> <4CA38538.8000007@caviumnetworks.com> <alpine.DEB.1.10.1009300218380.25860@tp.orcam.me.uk> <20101008053656.GU19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.codesourcery.com ([38.113.113.100]:37203 "EHLO
	mail.codesourcery.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab0JPAZ7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2010 20:25:59 -0400
In-Reply-To: <20101008053656.GU19804@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: David Daney <ddaney@caviumnetworks.com>, Al Viro <viro@ftp.linux.org.uk>, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>

On Fri, 8 Oct 2010, Al Viro wrote:

> BTW, with original code regs->regs[0] *can* be 1, if you are leaving syscall
> with -EINVAL.  It won't reach the userland, though.

 That's all I'm concerned about, thanks.

  Maciej
