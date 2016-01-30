Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42992 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbcA3HH5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2016 02:07:57 -0500
Date: Fri, 29 Jan 2016 23:07:56 -0800 (PST)
Message-ID: <20160129.230756.900527305484863684.davem@davemloft.net>
Subject: Re: [PATCH 12/12] sparc32: debride memcpy.S a bit
From: David Miller <davem@davemloft.net>
In-Reply-To: <1454095114-4128-12-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
	<1454095114-4128-12-git-send-email-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160130070756.5QftGTjUPF7Om400lvxLuvNphZwaEeXLwnGpqpvje6w@z>

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Fri, 29 Jan 2016 19:18:34 +0000

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> unreachable code, unused macros...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
