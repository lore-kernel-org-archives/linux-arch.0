From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Date: Tue, 5 Aug 2008 14:18:05 +1000
Message-ID: <200808051418.05324.rusty@rustcorp.com.au>
References: <20080728200500.GA14284@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:47447 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbYHEES3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Aug 2008 00:18:29 -0400
In-Reply-To: <20080728200500.GA14284@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tuesday 29 July 2008 06:05:00 Sam Ravnborg wrote:
> is is suggested to move the arch specific files under arch/
> and for the header files this is arch/$ARCH/include.

Well, it would have been nice to take the opportunity to separate user-visible 
header files and non-user-visible files.  We could have left the user-visible 
ones in place, for example: diffstat would then show when you were frobbing 
the userspace interface.

But I'm guessing noone wants even more marginal-value churn right now.
Rusty.
