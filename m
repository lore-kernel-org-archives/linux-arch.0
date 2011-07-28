From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage
Date: Thu, 28 Jul 2011 09:15:56 +0200
Message-ID: <20110728071556.GA6497@elte.hu>
References: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:56813 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144Ab1G1HQn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Jul 2011 03:16:43 -0400
Content-Disposition: inline
In-Reply-To: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org


* Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> I don't think there really is any rocket science or contentious 
> stuff here. It is a sensible cleanup that adds organization and 
> speeds up compiles. The RFC I'm hoping for is more about how/when 
> we want to get this in tree.

I'd suggest to stick it into linux-next ASAP, leave there for a few 
days and after fixing any potential fallout send it Linuswards.

Acked-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
