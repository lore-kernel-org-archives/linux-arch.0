From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 1/8] init: rename CONFIG_EMBEDDED to CONFIG_EXPERT
Date: Thu, 30 Dec 2010 10:04:23 +0100
Message-ID: <20101230090423.GA7306@elte.hu>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:34793 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177Ab0L3JEk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Dec 2010 04:04:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


* David Rientjes <rientjes@google.com> wrote:

> The meaning of CONFIG_EMBEDDED has long since been obsoleted; the option
> is used to configure any non-standard kernel with a much larger scope
> than only small devices.
> 
> This patch renames the option to CONFIG_EXPERT in init/Kconfig and fixes
> references to the option in the same file.  Followup patches will fix the
> remainder of the occurrences in the tree.
> 
> Calling the option "EXPERT" more accurately represents its intention:
> only expert users who understand the impact of the configuration changes
> they are making should enable it.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

Nice! For all patches:

Reviewed-by: Ingo Molnar <mingo@elte.hu>

	Ingo
