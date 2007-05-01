Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.239]:33317 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945997AbXEAUoC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2007 16:44:02 -0400
Received: by hu-out-0506.google.com with SMTP id 36so5792276hui
        for <linux-arch@vger.kernel.org>; Tue, 01 May 2007 13:44:00 -0700 (PDT)
Message-ID: <a781481a0705011344q7fccb586r8a31d2754e76d396@mail.gmail.com>
Date: Wed, 2 May 2007 02:14:00 +0530
From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: condingstyle, was Re: utrace comments
In-Reply-To: <1178032014.2875.80.camel@pmac.infradead.org>
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
	 <20070501080544.459a6ec9.randy.dunlap@oracle.com>
	 <1178032014.2875.80.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 5/1/07, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2007-05-01 at 08:05 -0700, Randy Dunlap wrote:
> > I prefer this format also, but I'm not sure that we can get it
> > into CodingStyle.  CodingStyle is about (either) concensus or
> > dictum, but I don't see us close to concensus...

Yes, some of these styles are too personal and subjective to even try
and standardize. And then often even the same person doesn't follow a
single convention across his own code. More likely you'd succeed
standardizing *religion* than this ...

> CodingStyle is mostly about consensus. We don't have a consensus, which
> is why this particular stuff isn't specified in CodingStyle. :)

Actually, I'm not sure if we really gain much by finding consensus for
this particular stuff. Most compound conditions only contain upto 3-4
operators/expressions, so most of the styles discussed here would be
almost equally readable. And any code that goes beyond 3-4
operators/expressions is probably ugly in many other ways and needs to
fix its logic.
