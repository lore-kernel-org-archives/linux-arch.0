Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:17300 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263588AbUELX6G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 May 2004 19:58:06 -0400
Date: Wed, 12 May 2004 16:57:06 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: Fw: Re: Reduce TLB flushing during process migration
Message-Id: <20040512165706.14d3b0ea.davem@redhat.com>
In-Reply-To: <20040512153203.5ac1b196.akpm@osdl.org>
References: <20040512153203.5ac1b196.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, steiner@sgi.com, mort@wildopensource.com, jbarnes@sgi.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 12 May 2004 15:32:03 -0700
Andrew Morton <akpm@osdl.org> wrote:

> davem, you expressed interest in this previously.  The question is whether
> we should remove the whole thing, or just the ia64 component?

It doesn't do anything for me on sparc64.  As per the change
description, it's a benefit also on platforms like x86 where
context-switch == tlb flush anyways.

At least that was my understanding.

If it's beneficial to the ia64 folks, I'm ambivalent, so just
put the fixed version back in once available.
