Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46724 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab1CQSae (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2011 14:30:34 -0400
Subject: Re: Poll about irqsafe_cpu_add and others
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <alpine.DEB.2.00.1103171245430.16620@router.home>
References: <1300371834.6315.93.camel@edumazet-laptop>
	 <20110317.081420.71114992.davem@davemloft.net>
	 <alpine.DEB.2.00.1103171016270.12540@router.home>
	 <1300380801.6315.306.camel@edumazet-laptop>
	 <alpine.DEB.2.00.1103171245430.16620@router.home>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 19:29:29 +0100
Message-ID: <1300386569.6315.404.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Message-ID: <20110317182929.aKEiTlqhEzhsF9_smTD9Q0uGioE9ZtGvIBOqT9szZx8@z>

Le jeudi 17 mars 2011 à 12:46 -0500, Christoph Lameter a écrit :
> On Thu, 17 Mar 2011, Eric Dumazet wrote:
> 
> > When we know we run from BH context, we can use __this_cpu_inc(), but if
> > we dont know or run from user/process context, we would need irqsafe_inc
> > variant.
> 
> If the BH context is the only one where we care about performance then its
> ok I would think.

Hmm... yes.

By the way, I noticed :

DECLARE_PER_CPU(u64, xt_u64);
__this_cpu_add(xt_u64, 2) translates to following x86_32 code :

	mov	$xt_u64,%eax
	add	%fs:0x0,%eax
	addl	$0x2,(%eax)
	adcl	$0x0,0x4(%eax)


I wonder why we dont use :

	addl	$0x2,%fs:xt_u64
	addcl	$0x0,%fs:xt_u64+4



