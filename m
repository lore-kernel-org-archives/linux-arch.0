Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262635AbUKEJFz@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:43166 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262632AbUKEJFz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Nov 2004 04:05:55 -0500
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id iA595s908650
	for <linux-arch@vger.kernel.org>; Fri, 5 Nov 2004 01:05:54 -0800
Date: Fri, 5 Nov 2004 01:05:54 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: 2.6.10-rc1-mm3
Message-Id: <20041105010554.084ddf84.akpm@osdl.org>
In-Reply-To: <20041105005257.2dc4408e.akpm@osdl.org>
References: <20041105005257.2dc4408e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton <akpm@osdl.org> wrote:
>
> That reminds me, I need to do a does-it-bloat-the-kernel check...

It adds 300 bytes to a 4M image.  Livable with ;)
