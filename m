From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Sat, 26 May 2012 19:46:38 -0400 (EDT)
Message-ID: <20120526.194638.2031616229448186690.davem@davemloft.net>
References: <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
	<CACM3HyFDY96F5kfsVCRQbx+8J+BUDCWXPqQVuLwOXRefS0Gcvg@mail.gmail.com>
	<CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:33263 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab2EZXqs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 19:46:48 -0400
In-Reply-To: <CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: jonas@southpole.se, linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 May 2012 11:39:10 -0700

> Ok, guys, there's a "generic-string-functions" branch in my regular
> git repositories that has the cleaned-up commit series.
> 
> Can you guys double-check that everything looks good,
 ...

Looks great and boots/works fine on sparc.
