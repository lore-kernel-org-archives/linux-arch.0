From: Paul Mackerras <paulus@samba.org>
Subject: Re: [rfc] add io barriers, remove mmiowb
Date: Fri, 23 May 2008 09:59:50 +1000
Message-ID: <18486.2294.23605.80728@cargo.ozlabs.ibm.com>
References: <20080521152855.GE8897@wotan.suse.de>
	<yq0fxsaivo4.fsf@jaguar.mkp.net>
	<20080522095121.GA18012@wotan.suse.de>
	<483566E7.8010703@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:35103 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759205AbYEVX7z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 May 2008 19:59:55 -0400
In-Reply-To: <483566E7.8010703@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, jbarnes@virtuousgeek.org, Linus Torvalds <torvalds@linux-foundation.org>

Jes Sorensen writes:

> I believe there's a fair number of places where wmb() is used for
> memory ordering not related to IO.

Shouldn't those places be using smp_wmb() then?

Paul.
