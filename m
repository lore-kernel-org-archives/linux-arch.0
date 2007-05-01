Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:40953 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031660AbXEAKjx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 May 2007 06:39:53 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4FDD72162A
	for <linux-arch@vger.kernel.org>; Tue,  1 May 2007 12:39:52 +0200 (CEST)
Date: Tue, 1 May 2007 13:37:33 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: You might need vmalloc_sync_all()
Message-ID: <20070501113733.GW25929@bingen.suse.de>
References: <20070501042655.GL25929@bingen.suse.de> <20070501074419.GA8120@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070501074419.GA8120@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> What's this?

Hmm, when I look now at your source I don't see one either. Maybe
the reporter had a strangely patched kernel.

Anyways, point stands -- for on demand module mappings you likely
want vmalloc_sync_all to avoid nested faults. If you think you 
can handle the nested faults safely then ignore it @)

> 
> > Apparently at least ARM has this problem.
> 
> Is there a bug report?

Forwarded it.

-Andi
