Return-Path: <roland@redhat.com>
Received: from mail5.speakeasy.net ([216.254.0.205]:38337 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S262791AbUCWTfO
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 14:35:14 -0500
Date: Tue, 23 Mar 2004 11:35:09 -0800
Message-Id: <200403231935.i2NJZ99O005609@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: signal-race-fix.patch
In-Reply-To: Andrew Morton's message of  Tuesday, 23 March 2004 02:20:20 -0800 <20040323022020.3972af1d.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Corey Minyard <minyard@acm.org>, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

There is nothing wrong with this patch.  But while we are at it (and every
arch will be required to update anyway), I would favor moving the sa_mask
processing into common code in get_signal_to_deliver right next to where
Corey has moved the SA_ONESHOT handling.


Thanks,
Roland
