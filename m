Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:58793 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfDLONb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Apr 2019 10:13:31 -0400
From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build with Sphinx
In-Reply-To: <27303.1555071586@warthog.procyon.org.uk>
References: <94c47f05-0412-b938-908d-1ef8a91243ed@darmarit.de> <cover.1554889999.git.mchehab+samsung@kernel.org> <18261.1555064496@warthog.procyon.org.uk> <27303.1555071586@warthog.procyon.org.uk>
Date: Fri, 12 Apr 2019 17:13:33 +0300
Message-ID: <87mukvgvle.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Markus Heiser <markus.heiser@darmarit.de>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Andrea Parri <andrea.parri@amarulasolutions.com>, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>
Message-ID: <20190412141333.ZZXIyUJ5WDisK-jepvHJnCFKTpKcsxr8uA15as-NXWo@z>

On Fri, 12 Apr 2019, David Howells <dhowells@redhat.com> wrote:
> Markus Heiser <markus.heiser@darmarit.de> wrote:
>
>> Which is already named in our 'How to write kernel documentation' introduction
>> 
>> - https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#writing-documentation
>
> This should really be in Documentation/ directory.

It is. Documentation/doc-guide/sphinx.rst.

Just double checking, you do know that all of [1] is generated from
Documentation/ using 'make html'?

BR,
Jani.


[1] https://www.kernel.org/doc/html/latest/


-- 
Jani Nikula, Intel Open Source Graphics Center
