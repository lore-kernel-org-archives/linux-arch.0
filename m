Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267552AbUH0TdG@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:32431 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267543AbUH0T2M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Aug 2004 15:28:12 -0400
Date: Fri, 27 Aug 2004 12:27:44 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: bug in syscal arg sign extension
Message-Id: <20040827122744.6a0c4258.davem@redhat.com>
In-Reply-To: <20040827155247.GA1024@wotan.suse.de>
References: <20040826180802.4f1e6dbb.davem@redhat.com>
	<20040827155247.GA1024@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 27 Aug 2004 17:52:47 +0200
Andi Kleen <ak@suse.de> wrote:

> But some entries I don't understand. e.g. why are you sign
> extending open or prctl? 

Just for completeness.
