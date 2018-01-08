Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:41602 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932668AbeAHQ3V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Jan 2018 11:29:21 -0500
Date: Mon, 8 Jan 2018 09:29:17 -0700
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 02/18] Documentation: document nospec helpers
Message-ID: <20180108092917.591359aa@lwn.net>
In-Reply-To: <151520100323.32271.8384226462583945132.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520100323.32271.8384226462583945132.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, Will Deacon <will.deacon@arm.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com
Message-ID: <20180108162917.F-zpxlQxIfk5AN3aQSK24_yxbCmzinB24XgtArllc3Y@z>

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
