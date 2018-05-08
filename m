From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Date: Tue, 8 May 2018 18:17:06 +0000
Message-ID: <20180508181706.GI27853@wotan.suse.de>
References: <e2aa9491-c1e3-4ae1-1ab2-589a6642a24a@infradead.org>
 <20180507231506.4891-1-mcgrof@kernel.org>
 <32208.1525768094@warthog.procyon.org.uk>
 <20180508112321.GA30120@bombadil.infradead.org>
 <7d6664dc-01f5-55d9-d309-0378ff609b8a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7d6664dc-01f5-55d9-d309-0378ff609b8a@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, arnd@arndb.de, cl@linux.com, keescook@chromium.org, luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 08, 2018 at 08:39:30AM -0700, Randy Dunlap wrote:
> On 05/08/2018 04:23 AM, Matthew Wilcox wrote:
> > On Tue, May 08, 2018 at 09:28:14AM +0100, David Howells wrote:
> >> Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >>>> + * execute a critial path. We should be mindful and selective if its use.
> >>>
> >>>                                                                  of its use.
> >>
> >>                                                                    in its use.
> > 								     with its use.
> > 
> > Nah, just kidding.  Let's go with "in".
> > 
> 
> Yeah, no, I don't care.  Just flip a 3-sided coin.

Heh, the coin says "of".

I also added:

 * ie: if you're going to use it please supply a *good* justification in your   
 * commit log.

Sending v2.

  Luis
