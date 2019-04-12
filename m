Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2-4.goneo.de ([85.220.129.36]:52043 "EHLO smtp2-4.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfDLKki (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Apr 2019 06:40:38 -0400
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build with
 Sphinx
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
 <18261.1555064496@warthog.procyon.org.uk>
From: Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <94c47f05-0412-b938-908d-1ef8a91243ed@darmarit.de>
Date: Fri, 12 Apr 2019 12:31:54 +0200
MIME-Version: 1.0
In-Reply-To: <18261.1555064496@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Andrea Parri <andrea.parri@amarulasolutions.com>, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>
Message-ID: <20190412103154.zvGY2njTRatkQOv_2lS8H1xwHAS1v14MsNLhCgWpAQA@z>


Am 12.04.19 um 12:21 schrieb David Howells:
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
>> In the past, we did some efforts to ensure that almost all files under
>> Documentation/*.txt could be built with Sphinx.
> 
> Would recommend a URL.  Presumably this: http://www.sphinx-doc.org

I recommend the Sphinx reStructuredText Primer

- https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html

Which is already named in our 'How to write kernel documentation' introduction

- https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#writing-documentation


-- Markus --
