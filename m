Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54045 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935518AbXGKXko (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jul 2007 19:40:44 -0400
Date: Wed, 11 Jul 2007 16:40:29 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Pass -g to assembler under CONFIG_DEBUG_INFO
In-Reply-To: <20070711160335.8705f742.akpm@linux-foundation.org>
Message-ID: <alpine.LFD.0.999.0707111640030.20061@woody.linux-foundation.org>
References: <46955BB1.20200@windriver.com> <20070711224327.9B0ED4D0555@magilla.localdomain>
 <20070711160335.8705f742.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Roland McGrath <roland@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 11 Jul 2007, Andrew Morton wrote:
>
> OK, thanks.  So I ended up with the below as a probably-2.6.23 thing:
> ...
> +AFLAGS		+= $(call as-option, -gdwarf)

"-gdwarf2?"

		Linus
