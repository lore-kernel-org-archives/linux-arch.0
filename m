Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:26288 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263928AbUEMHnh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 03:43:37 -0400
Date: Thu, 13 May 2004 09:43:36 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: Fw: Re: Reduce TLB flushing during process migration
Message-ID: <20040513074336.GB27682@wotan.suse.de>
References: <20040512153203.5ac1b196.akpm@osdl.org> <20040512165706.14d3b0ea.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512165706.14d3b0ea.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, steiner@sgi.com, mort@wildopensource.com, jbarnes@sgi.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, May 12, 2004 at 04:57:06PM -0700, David S. Miller wrote:
> > davem, you expressed interest in this previously.  The question is whether
> > we should remove the whole thing, or just the ia64 component?
> 
> It doesn't do anything for me on sparc64.  As per the change
> description, it's a benefit also on platforms like x86 where
> context-switch == tlb flush anyways.

Hmm, are you sure? How would that help? 

-Andi
