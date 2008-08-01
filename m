From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to
	convert
Date: Fri, 01 Aug 2008 10:35:12 +0200
Message-ID: <1217579712.10483.7.camel@localhost>
References: <20080728200500.GA14284@uranus.ravnborg.org>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:13344 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYHAIfP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Aug 2008 04:35:15 -0400
In-Reply-To: <20080728200500.GA14284@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, 2008-07-28 at 22:05 +0200, Sam Ravnborg wrote:
> So I have hacked up support for this in kbuild so
> for the simpler cases a simple move of header files as
> in:
> 	git mv include/asm-$ARCH arch/$ARCH/include/asm
> 
> is enough.

Just tested it on s390. We need a tiny fix for the qeth driver then it
works just fine (qeth has two includes for include/asm-s390 instead of
include/asm). I'll queue the qeth fix on git390. The only question is
who will do the move? 

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
