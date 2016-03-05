From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v2] x86: PAT: Documentation: rewrite "MTRR effects on PAT
 / non-PAT systems"
Date: Sat, 5 Mar 2016 02:03:46 +0100
Message-ID: <20160305010346.GW25240@wotan.suse.de>
References: <20160304210900.GT3577@linux.vnet.ibm.com>
 <1457131501-14855-1-git-send-email-mcgrof@kernel.org>
 <20160305000304.GA3577@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160305000304.GA3577@linux.vnet.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, bp@alien8.de
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, toshi.kani@hp.com, airlied@redhat.com, benh@kernel.crashing.org, mst@redhat.com, vinod.koul@intel.com, jgross@suse.com, daniel.vetter@ffwll.ch, luto@amacapital.net, davem@davemloft.net, ben@decadent.org.uk, benjamin.poirier@gmail.com, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 04, 2016 at 04:03:04PM -0800, Paul E. McKenney wrote:
> On Fri, Mar 04, 2016 at 02:45:01PM -0800, Luis R. Rodriguez wrote:
> > The current documentation refers to using set_memory_wc() as a
> > possible hole strategy when you have overlapping ioremap() regions,
> > that's incorrect as set_memory_*() helpers can only be used on RAM,
> > not IO memory. Using set_memory_wc() will not fail, that's a problem
> > which must be corrected in the future. This fixes that, and updates
> > the documention to *strongly* discourage overlapping ioremap() memory
> > uses, but also documents a possible solution should there really be
> > no other option to remain compatible on both PAT and MTRR memory
> > constarained systems. While at it, this provides some same guidlines
> > to system designers to remain sane and compatible on both PAT and
> > non-PAT systems.
> > 
> > As per Toshi this also fixes the table for the effective memory type
> > when using MTRR WC on PAT UC- to WC.
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> And I was really confused during my earlier reply.  For some reason
> I read the filename as memory-barriers.txt.
> 
> This one is not mine.  Too much time in standards committee meetings,
> I guess.  ;-)

Heh, OK yeah I was confused why you wanted to pick it up but played along.
Boris, can this go through you as its a follow up that previously went
through you ?

  Luis
