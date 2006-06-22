Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59790 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161094AbWFVL7y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Jun 2006 07:59:54 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.17] Standardize i386/x86_64 handling of NMI_VECTOR
Date: Thu, 22 Jun 2006 13:59:46 +0200
References: <18463.1150976798@ocs3.ocs.com.au>
In-Reply-To: <18463.1150976798@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606221359.46092.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@sgi.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thursday 22 June 2006 13:46, Keith Owens wrote:
> Andi Kleen (on Thu, 22 Jun 2006 12:48:21 +0200) wrote:
> >On Thursday 22 June 2006 11:01, Keith Owens wrote:
> >> x86_64 and i386 behave inconsistently when sending an IPI on vector 2
> >> (NMI_VECTOR).  Make both behave the same, so IPI 2 is sent as NMI.
> >> 
> >> The crash code was abusing send_IPI_allbutself() by passing a code
> >> instead of a vector, it only worked because crash knew about the
> >> internal code of send_IPI_allbutself().  Change crash to use NMI_VECTOR
> >> instead, and remove the comment about how crash was abusing the function.
> >
> >Does that fix anything? 
> 
> This patch is a pre-requisite for fixing the problem where sending an
> IPI as NMI would reboot some Dell Xeon systems.  I cannot fix that
> problem while crash continus to abuse send_IPI_allbutself().

I merged it with the updated description. Thanks.

-Andi
