Return-Path: <anton@samba.org>
Received: from dp.samba.org ([66.70.73.150]:54698 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262758AbUDAICa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2004 03:02:30 -0500
Date: Thu, 1 Apr 2004 17:58:30 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: generalize/fix wchan calculation via ELF sections
Message-ID: <20040401075830.GH27453@krispykreme>
References: <20040331073539.GX791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331073539.GX791@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> The following patch generalizes/fixes wchan calculations via ELF sections.
> I've tried to sweep all arches, which is where arch ppl come in.
> 
> Basically, I'm looking to see if I flubbed the patch and may not have
> swept all arches properly, or whether arch maintainers dislike whatever
> aspects of it since it goes poking around their code. Whatever kind of
> feedback may be relevant wrt. methods/cleanliness/etc. is also good.

Good work, I like a lot :)

Anton
