Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266793AbUHIRuG@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:8145 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266790AbUHIRuG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 13:50:06 -0400
Date: Mon, 9 Aug 2004 10:45:29 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: copy_page_range()
Message-Id: <20040809104529.4c5c0d5b.davem@redhat.com>
In-Reply-To: <16663.15729.828367.307053@napali.hpl.hp.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
	<16663.15729.828367.307053@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 9 Aug 2004 02:01:37 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> I didn't recall copy_page_range() being so high on ia64, but it's been
> a while since looked at this, so I ran it again

I really meant clear_page_tables(), sorry. :-)
