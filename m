From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Do we use runtime patching of function calls somewhere?
Date: Sun, 13 May 2012 08:29:35 -0600
Message-ID: <20120513142935.GC18390@parisc-linux.org>
References: <20120513121600.GA15708@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:48702 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab2EMO3h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2012 10:29:37 -0400
Content-Disposition: inline
In-Reply-To: <20120513121600.GA15708@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Sun, May 13, 2012 at 02:16:00PM +0200, Sam Ravnborg wrote:
> Do we have any archs that does runtime patching of function calls?

Isn't this a slightly easier version of the x86 altinstructions mechanism?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
