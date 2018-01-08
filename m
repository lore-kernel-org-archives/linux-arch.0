From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 02/18] Documentation: document nospec helpers
Date: Mon, 8 Jan 2018 14:19:27 -0700
Message-ID: <20180108141927.61427ad9@lwn.net>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520100323.32271.8384226462583945132.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20180108092917.591359aa@lwn.net>
        <20180108170959.pmwkgbosfv2oiuvc@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180108170959.pmwkgbosfv2oiuvc@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, Will Deacon <will.deacon@arm.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On Mon, 8 Jan 2018 17:09:59 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> > I have just a couple of overall comments.
> > 
> >  - It would be nice if the document were done in RST and placed in the
> >    core-API manual, perhaps using kerneldoc comments for the macros
> >    themselves.  It's already 99.9% RST now, so the changes required would
> >    be minimal.  
> 
> Is there any quickstart guide to RST that you can recommend?

http://docutils.sourceforge.net/docs/user/rst/quickref.html works
reasonably well.  We have some info in the kernel documentation as well,
see http://static.lwn.net/kerneldoc/doc-guide/sphinx.html

Thanks,

jon
