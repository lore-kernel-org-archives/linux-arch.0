Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267595AbUIOEuD@vger.kernel.org>
Received: from are.twiddle.net ([64.81.246.98]:8322 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S267526AbUIOEuD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 00:50:03 -0400
Received: from are.twiddle.net (localhost.localdomain [127.0.0.1])
	by are.twiddle.net (8.12.11/8.12.11) with ESMTP id i8F4nhYT001335
	for <linux-arch@vger.kernel.org>; Tue, 14 Sep 2004 21:49:43 -0700
Date: Tue, 14 Sep 2004 21:49:22 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: waitid fallout
Message-ID: <20040915044922.GA1288@twiddle.net>
References: <20040915033903.GA904@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915033903.GA904@twiddle.net>
To: roland@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 14, 2004 at 08:39:03PM -0700, Richard Henderson wrote:
> Is an *entire* struct rusage required in siginfo_t for sigchld?

FWIW, I don't see anything in 

  http://www.opengroup.org/onlinepubs/009695399/functions/waitid.html
  http://www.opengroup.org/onlinepubs/009695399/basedefs/signal.h.html

that mentions rusage at all.  From whence does this feature arise?


r~
