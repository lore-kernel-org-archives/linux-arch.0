Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:50243 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab1JPAx3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2011 20:53:29 -0400
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com [172.25.149.7])
	by smtp-out.google.com with ESMTP id p9G0rSOZ029982
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 17:53:28 -0700
Received: from pzk1 (pzk1.prod.google.com [10.243.19.129])
	by hpaq7.eem.corp.google.com with ESMTP id p9G0rPnA005270
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 17:53:27 -0700
Received: by pzk1 with SMTP id 1so1151770pzk.5
        for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 17:53:25 -0700 (PDT)
Date: Sat, 15 Oct 2011 17:53:23 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: Please include const-sections into linux-next
In-Reply-To: <1318722567.7271.56.camel@dabdike.int.hansenpartnership.com>
Message-ID: <alpine.DEB.2.00.1110151752060.5728@chino.kir.corp.google.com>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com> <alpine.DEB.2.00.1110151543220.25063@chino.kir.corp.google.com> <1318722567.7271.56.camel@dabdike.int.hansenpartnership.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20111016005323.T7Of5XBvqU37LPPu80XU0aWyJwgGeeBxcSozE7dZQAk@z>

On Sat, 15 Oct 2011, James Bottomley wrote:

> I think it's probably a compiler bug.  gcc isn't as adept with section
> annotations as people think it is.  This tends to manifest in the
> non-x86 toolchains because we tend to be using earlier versions.
> 

It compiles fine with my cross-compiler using gcc-4.5.1.
