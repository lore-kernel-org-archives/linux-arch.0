Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:54500 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262063AbUCXWEW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Mar 2004 17:04:22 -0500
Date: Wed, 24 Mar 2004 14:04:19 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] swp_entry_t vs. swap pte.
Message-Id: <20040324140419.29ec6a69.davem@redhat.com>
In-Reply-To: <20040324180939.GA2599@mschwid3.boeblingen.de.ibm.com>
References: <20040324180939.GA2599@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 24 Mar 2004 19:09:39 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> I created a patch that should fix the problem. It uses 
> 
>   swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))
> 
> to find the highest possible swap type number and
> 
>   swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0,~0UL))))
> 
> to find the highest possible swap offset. This should work with the
> existing __swp_entry/__swp_type/__swp_offset definitions for all
> architectures except for s390 because I've added a BUG_ON in
> __swp_entry if the created swap pte is dubious.  Oh, well.

This looks fine to me Martin.

I'm not going to fiddle with the swp bit fields on sparc64, the
offset range is huge enough :-)
