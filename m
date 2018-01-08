From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 02/18] Documentation: document nospec helpers
Date: Mon, 8 Jan 2018 09:29:17 -0700
Message-ID: <20180108092917.591359aa@lwn.net>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520100323.32271.8384226462583945132.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151520100323.32271.8384226462583945132.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, Will Deacon <will.deacon@arm.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On Fri, 05 Jan 2018 17:10:03 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Document the rationale and usage of the new nospec*() helpers.

I have just a couple of overall comments.

 - It would be nice if the document were done in RST and placed in the
   core-API manual, perhaps using kerneldoc comments for the macros
   themselves.  It's already 99.9% RST now, so the changes required would
   be minimal.

 - More importantly: is there any way at all to give guidance to
   developers wondering *when* they should use these primitives?  I think
   it would be easy to create a situation where they don't get used where
   they are really needed; meanwhile, there may well be a flood of
   "helpful" patches adding them where they make no sense at all.

Thanks,

jon
