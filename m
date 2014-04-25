From: Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH 25/28] nios2: ptrace support
Date: Sat, 26 Apr 2014 00:52:07 +0100
Message-ID: <535AF527.80601@redhat.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <1397824031-4892-22-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaDYXwO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Apr 2014 19:52:14 -0400
In-Reply-To: <1397824031-4892-22-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com

Does this support PTRACE_GETREGSET / PTRACE_SETREGSET ?

IMO, the kernel shouldn't accept ports without those anymore.

And IMHO, we shouldn't even allow new ports having PTRACE_GETREGS.

http://sourceware.org/ml/archer/2010-q3/msg00193.html

-- 
Pedro Alves
