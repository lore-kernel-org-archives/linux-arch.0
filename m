Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:3491 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S935728AbWLDK0v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Dec 2006 05:26:51 -0500
Date: Mon, 4 Dec 2006 11:25:37 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch][rfc] rwsem: generic rwsem
Message-ID: <20061204102537.GA30390@wotan.suse.de>
References: <20061204100607.GA20529@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204100607.GA20529@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Dec 04, 2006 at 11:06:07AM +0100, Nick Piggin wrote:
> (resending with correct ML addresses, sorry)
> 
> Hi,
> 
> This patch needs review and testing from the architecture guys, but
> I would like to consider it because of the obvious maintenance benefits.

Hah, very important detail: patch is on top of Mathieu Desnoyers' recent
"[PATCH 1/2] atomic.h atomic64_t standardization", which gives us
atomic_long_cmpxchg on all architectures.

Nick
