Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbeEHLXo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 07:23:44 -0400
Date: Tue, 8 May 2018 04:23:21 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Message-ID: <20180508112321.GA30120@bombadil.infradead.org>
References: <e2aa9491-c1e3-4ae1-1ab2-589a6642a24a@infradead.org>
 <20180507231506.4891-1-mcgrof@kernel.org>
 <32208.1525768094@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32208.1525768094@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, arnd@arndb.de, cl@linux.com, keescook@chromium.org, luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20180508112321.QvFGLtz-1Ntfuyxn1PJA6nkyvvFYziSbIQDs42VdOno@z>

On Tue, May 08, 2018 at 09:28:14AM +0100, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > > + * execute a critial path. We should be mindful and selective if its use.
> > 
> >                                                                  of its use.
> 
>                                                                    in its use.
								     with its use.

Nah, just kidding.  Let's go with "in".
