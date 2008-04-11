From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 09:48:02 +0200
Message-ID: <20080411074802.GC6410@elte.hu>
References: <1207885132.22001.85.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759295AbYDKHs1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1207885132.22001.85.camel@brick>
Sender: linux-kernel-owner@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org


* Harvey Harrison <harvey.harrison@gmail.com> wrote:

> diff --git a/include/asm-x86/unaligned.h b/include/asm-x86/unaligned.h
> index 913598d..7ba2e1a 100644
> --- a/include/asm-x86/unaligned.h
> +++ b/include/asm-x86/unaligned.h

nice work - the x86 bits and the general concept:

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
