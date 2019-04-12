Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:45164 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLPjz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Apr 2019 11:39:55 -0400
Date: Fri, 12 Apr 2019 09:39:47 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build
 with Sphinx
Message-ID: <20190412093947.62913186@lwn.net>
In-Reply-To: <df609cad-fa5b-ac15-314f-ac8759771d90@darmarit.de>
References: <94c47f05-0412-b938-908d-1ef8a91243ed@darmarit.de>
        <cover.1554889999.git.mchehab+samsung@kernel.org>
        <18261.1555064496@warthog.procyon.org.uk>
        <27303.1555071586@warthog.procyon.org.uk>
        <df609cad-fa5b-ac15-314f-ac8759771d90@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Markus Heiser <markus.heiser@darmarit.de>
Cc: David Howells <dhowells@redhat.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Andrea Parri <andrea.parri@amarulasolutions.com>, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>
Message-ID: <20190412153947.vOowt4R-JYkALKiGnDCctruYQAzScdXcnGyRyLrIV1U@z>

On Fri, 12 Apr 2019 14:34:25 +0200
Markus Heiser <markus.heiser@darmarit.de> wrote:

> Am 12.04.19 um 14:19 schrieb David Howells:
> > Markus Heiser <markus.heiser@darmarit.de> wrote:
> >   
> >> Which is already named in our 'How to write kernel documentation' introduction
> >>
> >> - https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#writing-documentation  
> > 
> > This should really be in Documentation/ directory.
> >   
> 
> I agree with you, it is a kind of information hiding.  If you know proper
> places, please send a patch to Jon.

As Jani pointed out, it's in Documentation/doc-guide.

If you're saying it should be in the top level, I kind of disagree.
Documentation/ is an exercise in hiding information by placing it in the
middle of 200 other, unrelated files.  We've made some progress on that,
and I would like to continue to do so.

Thanks,

jon
