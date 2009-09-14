From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 11/11] Use unreachable() in asm-generic/bug.h for
 !CONFIG_BUG case.
Date: Mon, 14 Sep 2009 16:39:46 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909141637250.4950@localhost.localdomain>
References: <4AAEBAC2.1050905@caviumnetworks.com>  <1252965340-31735-11-git-send-email-ddaney@caviumnetworks.com> <73c1f2160909141612i32f46361q7430cecf0b68d07b@mail.gmail.com> <4AAED18E.7030903@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51667 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753655AbZINXkY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Sep 2009 19:40:24 -0400
In-Reply-To: <4AAED18E.7030903@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Brian Gerst <brgerst@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>



On Mon, 14 Sep 2009, David Daney wrote:
> 
> The existing code just falls through to whatever happens to follow the BUG().

Brian was talking BUG_ON().

And the existing !CONFIG_BUG BUG_ON() is actually set up so that gcc will 
just optimize it away entirely (yet give the same compile-time warnings as 
the "real" BUG_ON() does).

Changing it to "if (cond) unreachable()" is likely to generate _more_ 
code, which is against the whole point of wanting to disable CONFIG_BUG.

			Linus
