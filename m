Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:4495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264990AbUETGoS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 May 2004 02:44:18 -0400
Date: Wed, 19 May 2004 23:41:06 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
Message-Id: <20040519234106.52b6db78.davem@redhat.com>
In-Reply-To: <16556.19979.951743.994128@napali.hpl.hp.com>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
	<16556.19979.951743.994128@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, arnd@arndb.de, ak@suse.de, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 19 May 2004 23:19:55 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> How about the attached?  I decided to use __ARCH_OMIT_foo instead
> of SYS_NEED_foo since that keeps the extra code in those platforms
> that want to drop the code.

This looks OK to me.
