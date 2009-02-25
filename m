From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 14/15 v2] bitops: Change the bitmap index from int to unsigned long [frv]
Date: Wed, 25 Feb 2009 23:42:55 +0000
Message-ID: <7298.1235605375@redhat.com>
References: <200902252003.MAA12219@hpdst41.cup.hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47488 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763375AbZBYXpA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2009 18:45:00 -0500
In-Reply-To: <200902252003.MAA12219@hpdst41.cup.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Justin Chen <jchen@hpdst41.cup.hp.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org

Justin Chen <jchen@hpdst41.cup.hp.com> wrote:

> Change the index to be unsigned long in all bitops for [frv]
> 
> Signed-off-by: Justin Chen <justin.chen@hp.com>
> Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: David Howells <dhowells@redhat.com>
