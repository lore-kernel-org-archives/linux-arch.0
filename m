Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508AbXEAQNJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 May 2007 12:13:09 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.DEB.0.98.0705011054060.12931@sigma.j-a-k-j.com> 
References: <alpine.DEB.0.98.0705011054060.12931@sigma.j-a-k-j.com>  <20061127165138.GA2991@lst.de> <20070430040213.BF9901801A4@magilla.sf.frob.com> <20070430091121.GC31397@infradead.org> <20070430100917.439ebfc8.akpm@linux-foundation.org> <a781481a0704301142sfec317cu8213750c9ab84416@mail.gmail.com> <Pine.LNX.4.64.0705011058330.27246@anakin> <1178028973.2875.78.camel@pmac.infradead.org> 
Subject: Re: condingstyle, was Re: utrace comments 
Date: Tue, 01 May 2007 17:07:07 +0100
Message-ID: <9185.1178035627@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: "John Anthony Kazos Jr." <jakj@j-a-k-j.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Satyam Sharma <satyam.sharma@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

John Anthony Kazos Jr. <jakj@j-a-k-j.com> wrote:

> 	if (veryverylengthycondition1
> 		&& smallcond2
> 		&& (conditionnumber3a
> 			|| condition3b)) {
> 		...
> 	}
> 
> Clear, crisp, and 80-wide. I also like how the logical operator on the 
> following line is indented slightly into the condition of the previous 
> line.

The brain works better when associated things are lined up, so:

	if (veryverylengthycondition1 &&
	    smallcond2 &&
	    (conditionnumber3a ||
	     condition3b)) {

is better as it gives a visual clue to association.

David
