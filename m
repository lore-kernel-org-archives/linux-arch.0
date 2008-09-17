From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: How to write ports to new CPU and architecture?
Date: Wed, 17 Sep 2008 07:41:35 -0600
Message-ID: <20080917134134.GB5802@parisc-linux.org>
References: <48D0F9A2.60806@sesca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:45142 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYIQNlw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Sep 2008 09:41:52 -0400
Content-Disposition: inline
In-Reply-To: <48D0F9A2.60806@sesca.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Meng Sun <meng.sun@sesca.com>
Cc: linux-arch@vger.kernel.org

On Wed, Sep 17, 2008 at 03:35:46PM +0300, Meng Sun wrote:
> What should I do for implement Linux kernel on a new CPU and target
> board? I just read FAQ but it's just general information. Could you
> please tell me which documents(except CPU datasheets and target board
> documents) I should read?

Is it an existing processor such as PowerPC or MIPS?  If so, you should
approach that port directly and ask for advice (since it will differ
greatly from one architecture to another).

Is it a new processor that we don't currently have support for in the
kernel tree?  That's a much larger undertaking, normally a multi-year
project First, you're going to need a toolchain that targets your CPU --
GCC, binutils and so on.  Then you can start porting Linux.  It's
probably best to start by copying an existing architecture and modify it
piecemeal.

I can't really be more specific since your question is so vague.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
