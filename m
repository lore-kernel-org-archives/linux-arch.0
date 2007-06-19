Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58492
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753278AbXFSWeb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Jun 2007 18:34:31 -0400
Date: Tue, 19 Jun 2007 15:34:50 -0700 (PDT)
Message-Id: <20070619.153450.107921888.davem@davemloft.net>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070619123316.bccb926d.akpm@linux-foundation.org>
References: <1182154907.197287.4324.nullmailer@white.sw.ru>
	<20070619123316.bccb926d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: vtaras@openvz.org, dev@sw.ru, vvs@sw.ru, devel@openvz.org, linux-kernel@vger.kernel.org, nataliep@google.com, jack@suse.cz, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 19 Jun 2007 12:33:16 -0700

> Only x86_64 and ia64 are fixed.  Would it be correct to assume that the
> other CONFIG_COMPAT architectures also need to be fixed?

Only platforms which compat to "i386" have the issue wrt.
the alignment of "u64" types, which is "4" on i386 and
"8" on the platforms that compat to them.

This has been mentioned at least 3 times in this thread.
