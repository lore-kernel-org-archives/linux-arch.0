Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:52534 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757033AbYDKHsQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Apr 2008 03:48:16 -0400
Date: Fri, 11 Apr 2008 09:48:02 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Message-ID: <20080411074802.GC6410@elte.hu>
References: <1207885132.22001.85.camel@brick>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1207885132.22001.85.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080411074802.WEQgDxVRIXYXCyKN2MrZx5OOkrvTMg7oo0l8-VOvdbg@z>


* Harvey Harrison <harvey.harrison@gmail.com> wrote:

> diff --git a/include/asm-x86/unaligned.h b/include/asm-x86/unaligned.h
> index 913598d..7ba2e1a 100644
> --- a/include/asm-x86/unaligned.h
> +++ b/include/asm-x86/unaligned.h

nice work - the x86 bits and the general concept:

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
