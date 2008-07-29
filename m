From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to
	convert
Date: Mon, 28 Jul 2008 23:06:47 -0400
Message-ID: <20080729030647.GA11425@phobos.i.cabal.ca>
References: <20080728200500.GA14284@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754710AbYG2DHB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080728200500.GA14284@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 28, 2008 at 10:05:00PM +0200, Sam Ravnborg wrote:
> I am limited in time and resources at the moment but I
> would be glad to help out as time permits should there
> be any questions.
> 

Just a quick one... I moved the files on parisc, but found we're still
using include/asm-$foo/asm-offsets.h. A quick glance at Kbuild seems to
indicate so. Is this expected?

cheers, Kyle
