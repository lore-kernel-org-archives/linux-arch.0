From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build
 with Sphinx
Date: Thu, 11 Apr 2019 12:37:22 -0600
Message-ID: <20190411123722.67d8cbe6@lwn.net>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>
List-Id: linux-arch.vger.kernel.org

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
