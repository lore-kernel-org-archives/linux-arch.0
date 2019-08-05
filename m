From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Date: Mon, 05 Aug 2019 08:23:38 -0700
Message-ID: <1565018618.3341.6.camel@HansenPartnership.com>
References: <20190805121517.4734-1-parri.andrea@gmail.com>
         <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
         <20190805151545.GA1615@aparri>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805151545.GA1615@aparri>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <parri.andrea@gmail.com>, Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Mon, 2019-08-05 at 17:15 +0200, Andrea Parri wrote:
> > Why don't you also add an entry in .mailmap as Will did in commit
> > c584b1202f2d ("MAINTAINERS: Update my email address to use
> > @kernel.org")?
> 
> I considered it but could not understand its purpose...  Maybe you
> can explain it to me?  ;-) (can resend with this change if
> needed/desired).

man git-shortlog gives you the gory detail, but its use is to "coalesce
together commits by the same person in the shortlog, where their name
and/or email address was spelled differently."  The usual way this
happens is that people have the name that appears in the From field
with and without initials.

James
