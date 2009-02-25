From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/15] bitops: Change the bitmap index from int to unsigned long [mn10300]
Date: Wed, 25 Feb 2009 12:34:43 +0000
Message-ID: <14255.1235565283@redhat.com>
References: <200902250451.UAA12851@hpdst41.cup.hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47090 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbZBYMgw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2009 07:36:52 -0500
In-Reply-To: <200902250451.UAA12851@hpdst41.cup.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Justin Chen <jchen@hpdst41.cup.hp.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org, yasutake.koichi@jp.panasonic.com

Justin Chen <jchen@hpdst41.cup.hp.com> wrote:

> Change the index to unsigned long in all bitops for [mn10300]
> 
> Signed-off-by: Justin Chen <justin.chen@hp.com>
> Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: David Howells <dhowells@redhat.com>
