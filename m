From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 02/18] Documentation: document nospec helpers
Date: Mon, 8 Jan 2018 17:09:59 +0000
Message-ID: <20180108170959.pmwkgbosfv2oiuvc@lakrids.cambridge.arm.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520100323.32271.8384226462583945132.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180108092917.591359aa@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108092917.591359aa@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, Will Deacon <will.deacon@arm.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

Hi Jon,

On Mon, Jan 08, 2018 at 09:29:17AM -0700, Jonathan Corbet wrote:
> On Fri, 05 Jan 2018 17:10:03 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Document the rationale and usage of the new nospec*() helpers.
> 
> I have just a couple of overall comments.
> 
>  - It would be nice if the document were done in RST and placed in the
>    core-API manual, perhaps using kerneldoc comments for the macros
>    themselves.  It's already 99.9% RST now, so the changes required would
>    be minimal.

Is there any quickstart guide to RST that you can recommend?

I'm happy to clean up the documentation; I'm just not familiar with RST.

>  - More importantly: is there any way at all to give guidance to
>    developers wondering *when* they should use these primitives?  I think
>    it would be easy to create a situation where they don't get used where
>    they are really needed; meanwhile, there may well be a flood of
>    "helpful" patches adding them where they make no sense at all.

This is on my TODO list.

The unfortunate truth is that it's likely to be a subjective judgement
call in many cases, depending on how likely it is that the user can
influence the code in question, so it's difficult to provide
hard-and-fast rules.

Thanks,
Mark.
