Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.234]:12682 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbXEAUMV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2007 16:12:21 -0400
Received: by hu-out-0506.google.com with SMTP id 36so5780770hui
        for <linux-arch@vger.kernel.org>; Tue, 01 May 2007 13:12:20 -0700 (PDT)
Message-ID: <a781481a0705011312h44245a54k89ac9344424548be@mail.gmail.com>
Date: Wed, 2 May 2007 01:42:20 +0530
From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: condingstyle, was Re: utrace comments
In-Reply-To: <alpine.DEB.0.98.0705011054060.12931@sigma.j-a-k-j.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061127165138.GA2991@lst.de>
	 <20070430040213.BF9901801A4@magilla.sf.frob.com>
	 <20070430091121.GC31397@infradead.org>
	 <20070430100917.439ebfc8.akpm@linux-foundation.org>
	 <a781481a0704301142sfec317cu8213750c9ab84416@mail.gmail.com>
	 <Pine.LNX.4.64.0705011058330.27246@anakin>
	 <1178028973.2875.78.camel@pmac.infradead.org>
	 <alpine.DEB.0.98.0705011054060.12931@sigma.j-a-k-j.com>
Sender: linux-arch-owner@vger.kernel.org
To: "John Anthony Kazos Jr." <jakj@j-a-k-j.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 5/1/07, John Anthony Kazos Jr. <jakj@j-a-k-j.com> wrote:
> > It's horrid. I'd much rather see
> >
> >         if (veryverylengthycondition1 &&
> >             smallcond2 &&
> >             (conditionnumber3a || condition3b)) {
> >                 ...
> >         }
>
>         if (veryverylengthycondition1
>                 && smallcond2
>                 && (conditionnumber3a
>                         || condition3b)) {
>                 ...
>         }
>
> Clear, crisp, and 80-wide. I also like how the logical operator on the
> following line is indented slightly into the condition of the previous
> line. I think this is much more sensical and sensible than using spaces to
> line them up with the parentheses. Makes clear for each operator the
> condition to which it applies.

Hmmm ... I did use the spaces to line up the operators with the
starting column of the _expression_ in the previous lines, not the
parentheses (that would be gross!). Of course, && and || are binary
operators so they apply both to the expression on the previous line as
well as the expression following it on the same line.
