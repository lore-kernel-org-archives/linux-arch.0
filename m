Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:38746 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfDKShY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Apr 2019 14:37:24 -0400
Date: Thu, 11 Apr 2019 12:37:22 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build
 with Sphinx
Message-ID: <20190411123722.67d8cbe6@lwn.net>
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>
Message-ID: <20190411183722.L1e4TTqk4xSo6zpHXLUH8AeCFE3CB3xU1sP0d83bawQ@z>

On Wed, 10 Apr 2019 06:56:19 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> In the past, we did some efforts to ensure that almost all files under
> Documentation/*.txt could be built with Sphinx.
> 
> Some regressions happened there (and some new files got added).
> Fix those files in order to allow them to be able to build with Sphinx.
> 
> The changes on this series are trivial, adding the minimum stuff to allow
> building those files with sphinx-build with no warnings and to make the
> contents minimally consistent with other documentation files.

I've applied this set, thanks.

jon
