Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261759AbUKIWwk@vger.kernel.org>
Received: from [12.177.129.25] ([12.177.129.25]:56771 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261758AbUKIWwk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Nov 2004 17:52:40 -0500
Message-Id: <200411100105.iAA154g9005528@ccure.user-mode-linux.org>
Subject: Re: last call for 4-level-pagetable patches 
In-Reply-To: Your message of "Tue, 09 Nov 2004 12:29:19 PST."
             <20041109122919.49d8f2f5.akpm@osdl.org>
References: <20041109122919.49d8f2f5.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Nov 2004 20:05:04 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Paolo Giarrusso <blaisorblade_personal@yahoo.it>
List-ID: <linux-arch.vger.kernel.org>

akpm@osdl.org said:
> UML might need some work? 

Working on it, not a big deal.

It would be a bigger deal to have 4 working levels of page tables, but folding
pml4 is not hard.

				Jeff
