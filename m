Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:41724 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759272Ab3ICD1y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Sep 2013 23:27:54 -0400
Date: Mon, 02 Sep 2013 20:33:55 -0700 (PDT)
Message-ID: <20130902.203355.117341085023152754.davem@davemloft.net>
Subject: Re: [guv v2 04/31] net: Replace __get_cpu_var uses
From: David Miller <davem@davemloft.net>
In-Reply-To: <7435.1378157706@warthog.procyon.org.uk>
References: <00000140bc5ef9df-d7f75909-a25e-4471-84b2-dfbec07117b0-000000@email.amazonses.com>
	<20130826204351.725357339@linux.com>
	<7435.1378157706@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: cl@linux.com, tj@kernel.org, akpm@linuxfoundation.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org, srostedt@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <20130903033355.wmvckj8mM4o-0iyeJ89tu62vKtXQuid62zWdkBKmuzY@z>

From: David Howells <dhowells@redhat.com>
Date: Mon, 02 Sep 2013 22:35:06 +0100

> Would it be possible to use __thread annotations for per-CPU
> variables, I wonder?

Paul Mackerras tried it on powerpc and you can't do it.

The problem is that there is no way to tell the compiler that sched()
and similar (potentially) change the thread pointer base.

It really will cache pre-computed __thread pointer calculations across
sched().
