From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 9/14] mips: use generic ptrace_resume code
Date: Tue, 2 Feb 2010 20:19:19 +0100
Message-ID: <20100202191919.GA542@linux-mips.org>
References: <20100202185755.GA3630@lst.de>
 <20100202185958.GI3630@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:52557 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab0BBTTH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2010 14:19:07 -0500
Received: from localhost.localdomain ([127.0.0.1]:47347 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492548Ab0BBTTG (ORCPT <rfc822;linux-arch@vger.kernel.org>
        + 1 other); Tue, 2 Feb 2010 20:19:06 +0100
Content-Disposition: inline
In-Reply-To: <20100202185958.GI3630@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: roland@redhat.com, oleg@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Feb 02, 2010 at 07:59:58PM +0100, Christoph Hellwig wrote:

> Use the generic ptrace_resume code for PTRACE_SYSCALL, PTRACE_CONT and
> PTRACE_KILL.  
> 
> Also the TIF_SYSCALL_TRACE thread flag is now cleared on PTRACE_KILL
> which it previously wasn't which is consistent with all architectures
> using the modern ptrace code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
