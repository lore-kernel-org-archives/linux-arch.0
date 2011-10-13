From: Rusty Russell <rusty@ozlabs.org>
Subject: Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage
Date: Thu, 13 Oct 2011 12:37:47 +1030
Message-ID: <87botlej9o.fsf@rustcorp.com.au>
References: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:41491 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab1JMCJJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Oct 2011 22:09:09 -0400
In-Reply-To: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, mingo@elte.hu, torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org

On Thu, 28 Jul 2011 01:16:07 -0400, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> I don't think there really is any rocket science or contentious stuff here.
> It is a sensible cleanup that adds organization and speeds up compiles.
> The RFC I'm hoping for is more about how/when we want to get this in tree.

In future, when you're ripping into module.h, please CC the module
maintainer.  It's not just a courtesy, it helps everyone avoid redundant
work.

You may insert your own sarcastic comment about "rocket science" here.

As to the patch: it's marginal improvement, but it's neater and I'm
happy you're doing it.

Thanks,
Rusty.
