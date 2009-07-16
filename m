Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52964 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756939AbZGPB4Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jul 2009 21:56:25 -0400
Subject: Re: [RFC/PATCH] mm: Pass virtual address to
 [__]p{te,ud,md}_free_tlb()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1247708177.9851.4.camel@concordia>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	 <1247708177.9851.4.camel@concordia>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 11:56:05 +1000
Message-ID: <1247709365.27937.6.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michael@ellerman.id.au
Cc: Linux Memory Management <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@tiscali.co.uk>
Message-ID: <20090716015605.SwEQmg663HY3qRNrYVq_Hd_ZGEHF97jmy2YfS9FkCnA@z>

On Thu, 2009-07-16 at 11:36 +1000, Michael Ellerman wrote:
> 
> Builds for the important architectures, powerpc, ia64, arm, sparc,
> sparc64, oh and x86:
> 
> http://kisskb.ellerman.id.au/kisskb/head/1976/
> 
> (based on your test branch 34f25476)

Note for all lurkers: the fails in there are unrelated to the patch
(mostly warnings triggering our new Werror and probably mostly fixed
upstream already).

Cheers,
Ben.

