Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:7039 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161149AbWJKRNe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Oct 2006 13:13:34 -0400
Received: from spaceape8.eur.corp.google.com (spaceape8.eur.corp.google.com [172.28.16.142])
	by smtp-out.google.com with ESMTP id k9BHDS9G011687
	for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2006 18:13:31 +0100
Received: from nf-out-0910.google.com (nfal36.prod.google.com [10.48.63.36])
	by spaceape8.eur.corp.google.com with ESMTP id k9BHDR32013536
	for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2006 18:13:27 +0100
Received: by nf-out-0910.google.com with SMTP id l36so685755nfa
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2006 10:13:27 -0700 (PDT)
Message-ID: <65dd6fd50610111013t6c783f3esc038c64abbcddeb0@mail.gmail.com>
Date: Wed, 11 Oct 2006 10:13:26 -0700
From: "Ollie Wild" <aaw@google.com>
Subject: Re: Removing MAX_ARG_PAGES (request for comments/assistance)
In-Reply-To: <1160553621.3000.355.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
	 <1160553621.3000.355.camel@laptopd505.fenrus.org>
Sender: linux-arch-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>, linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

> on first sight it looks like you pin the entire userspace buffer at the
> same time (but I can misread the code; this stuff is a bit of a
> spaghetti by nature); that would be a DoS scenario if true...

I'm not sure I understand.  Could you please elaborate?

Thanks,
Ollie
