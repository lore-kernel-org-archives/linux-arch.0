Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267334AbUIUGRR@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:43906
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267333AbUIUGRR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Sep 2004 02:17:17 -0400
Date: Mon, 20 Sep 2004 23:17:06 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: x86-64-waitid-compat-fix
Message-Id: <20040920231706.471193e0.davem@davemloft.net>
In-Reply-To: <20040920204637.441097b6.akpm@osdl.org>
References: <20040920204055.577976a9.akpm@osdl.org>
	<20040920204637.441097b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 20 Sep 2004 20:46:37 -0700
Andrew Morton <akpm@osdl.org> wrote:

> This sparc64 fix compiles.

Looks fine.

> All (or most of) those casts in the sys_waitid() call seem to be unneeded -
> we have a prototype in scope...

You're probably right.
