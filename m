From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all
	architectures [try #5]
Date: Mon, 14 Sep 2009 09:48:59 -0400
Message-ID: <20090914134859.GE19494@bombadil.infradead.org>
References: <20090904142440.GM19494@bombadil.infradead.org> <20090903015707.GL19494@bombadil.infradead.org> <20090902072053.3578.69125.stgit@warthog.procyon.org.uk> <20090902072129.3578.81364.stgit@warthog.procyon.org.uk> <29063.1252047959@redhat.com> <32631.1252074944@redhat.com> <20090908141530.GQ19494@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-security-module-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090908141530.GQ19494@bombadil.infradead.org>
Sender: linux-security-module-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: David Howells <dhowells@redhat.com>, jmorris@namei.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 08, 2009 at 10:15:30AM -0400, Kyle McMartin wrote:
> On Fri, Sep 04, 2009 at 03:35:44PM +0100, David Howells wrote:
> > Kyle McMartin <kyle@mcmartin.ca> wrote:
> > 
> > > I don't think this depends on the previous patches in the series... it
> > > would probably be easiest if I just merged it with the rest of them
> > > though...
> > 
> > The problem I've got is that patch 9/9 depends on this change, but James
> > doesn't have your patch in his tree.
> > 
> 
> I'm planning to submit the tracehook branch immediately after the merge
> window opens... would it be a problem to do it in two quick stages?
> 
> Or just drop the parisc hunk until the rest of it goes upstream and then
> send that along?
> 

Thanks for just ignoring this. I really appreciate it.
