Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269392AbUH0IAD@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:3220 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269391AbUH0IAD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Aug 2004 04:00:03 -0400
Date: Fri, 27 Aug 2004 00:59:47 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: using-get_cycles-for-add_timer_randomness.patch
Message-Id: <20040827005947.45b29e8b.davem@redhat.com>
In-Reply-To: <20040826234005.2afdb353.akpm@osdl.org>
References: <20040826234005.2afdb353.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 26 Aug 2004 23:40:05 -0700
Andrew Morton <akpm@osdl.org> wrote:

> What's the status of this?  Is it a showstopper for MIPS?

It is impossible for this to make things any worse
than they are now, even if the platform returns zero
or jiffies for get_cycles().
