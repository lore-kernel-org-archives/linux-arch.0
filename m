From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 2/2] hugetlb: Replace BUG() with BUILD_BUG() for dummy definitions.
Date: Wed, 23 Nov 2011 11:11:40 +0000
Message-ID: <2694.1322046700@redhat.com>
References: <1321985686-798-3-git-send-email-ddaney.cavm@gmail.com> <1321985686-798-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35195 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab1KWLLv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 Nov 2011 06:11:51 -0500
In-Reply-To: <1321985686-798-3-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: dhowells@redhat.com, ralf@linux-mips.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, DM <dm.n9107@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <david.daney@cavium.com>

David Daney <ddaney.cavm@gmail.com> wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The file linux/hugetlb.h has many places where dummy symbols were
> defined so that the main source code would contain fewer:
> 
>     #ifdef CONFIG_HUGETLBFS
> 
> or
> 
>     #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 
> If there were any misuse of these symbols, the only symptom would be
> an OOPS at runtime.  Change the BUG() to BUILD_BUG() to catch
> any such abuse at compile time instead.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: David Howells <dhowells@redhat.com>
