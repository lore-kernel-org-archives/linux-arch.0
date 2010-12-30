From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/8] init: rename CONFIG_EMBEDDED to CONFIG_EXPERT
Date: Thu, 30 Dec 2010 13:50:28 +0100
Message-ID: <201012301350.28862.arnd@arndb.de>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com> <20101230124535.GA3306@sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57328 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0L3Muo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Dec 2010 07:50:44 -0500
In-Reply-To: <20101230124535.GA3306@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Holt <holt@sgi.com>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 30 December 2010, Robin Holt wrote:
> Doesn't this patch series break the 'bisectable' rule for patches?
> I think you can get by with adding a CONFIG_EXPERT selects CONFIG_EMBEDDED
> in the first patch and the last patch removing that same selects.

How about leaving it that way during the merge window even? That would
help people sending git pull requests that add new dependencies on
CONFIG_EMBEDDED. David can submit another patch that removes the
temporary CONFIG_EMBEDDED option along with any new users in -rc2
or for 2.6.39 then.

	Arnd
