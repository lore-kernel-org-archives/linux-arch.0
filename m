Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:19386 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261794AbUCaIDO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2004 03:03:14 -0500
Date: Wed, 31 Mar 2004 10:03:10 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: generalize/fix wchan calculation via ELF sections
Message-Id: <20040331100310.5afcde15.ak@suse.de>
In-Reply-To: <20040331073539.GX791@holomorphy.com>
References: <20040331073539.GX791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 30 Mar 2004 23:35:39 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> The following patch generalizes/fixes wchan calculations via ELF sections.
> I've tried to sweep all arches, which is where arch ppl come in.
> 
> Basically, I'm looking to see if I flubbed the patch and may not have
> swept all arches properly, or whether arch maintainers dislike whatever
> aspects of it since it goes poking around their code. Whatever kind of
> feedback may be relevant wrt. methods/cleanliness/etc. is also good.

Looks good to me. Thanks for doing this work.

-Andi
