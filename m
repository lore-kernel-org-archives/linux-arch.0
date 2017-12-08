Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdLHU5k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2017 15:57:40 -0500
Date: Fri, 8 Dec 2017 12:57:34 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171208205734.GB32293@bombadil.infradead.org>
References: <20171130065835.dbw4ajh5q5whikhf@dhcp22.suse.cz>
 <20171201152640.GA3765@rei>
 <87wp20e9wf.fsf@concordia.ellerman.id.au>
 <20171206045433.GQ26021@bombadil.infradead.org>
 <20171206070355.GA32044@bombadil.infradead.org>
 <87bmjbks4c.fsf@concordia.ellerman.id.au>
 <CAGXu5jLWRQn6EaXEEvdvXr+4gbiJawwp1EaLMfYisHVfMiqgSA@mail.gmail.com>
 <20171207195727.GA26792@bombadil.infradead.org>
 <20171208083315.GR20234@dhcp22.suse.cz>
 <CAGXu5j+VupGmKEEHx-uNXw27Xvndu=0ObsBqMwQiaYPyMGD+vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+VupGmKEEHx-uNXw27Xvndu=0ObsBqMwQiaYPyMGD+vw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Michal Hocko <mhocko@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Cyril Hrubis <chrubis@suse.cz>, Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Pavel Machek <pavel@ucw.cz>
Message-ID: <20171208205734.-u85pqlF6vdSFfoqcFC75ESauVtLZ6DRX1GpzhvhF54@z>

On Fri, Dec 08, 2017 at 12:13:31PM -0800, Kees Cook wrote:
> On Fri, Dec 8, 2017 at 12:33 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > OK, this doesn't seem to lead to anywhere. The more this is discussed
> > the more names we are getting. So you know what? I will resubmit and
> > keep my original name. If somebody really hates it then feel free to
> > nack the patch and push alternative and gain concensus on it.
> >
> > I will keep MAP_FIXED_SAFE because it is an alternative to MAP_FIXED so
> > having that in the name is _useful_ for everybody familiar with
> > MAP_FIXED already. And _SAFE suffix tells that the operation doesn't
> > cause any silent memory corruptions or other unexpected side effects.
> 
> Looks like consensus is MAP_FIXED_NOREPLACE.

I'd rather MAP_AT_ADDR or MAP_REQUIRED, but I prefer FIXED_NOREPLACE to
FIXED_SAFE.

I just had a thought though -- MAP_STATIC?  ie don't move it.
