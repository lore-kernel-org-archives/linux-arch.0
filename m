From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [PATCH 02/20] mm: generic show_mem()
Date: Sat, 28 Jun 2008 12:25:57 +0200
Message-ID: <87myl5ama2.fsf@skyscraper.fehenstaub.lan>
References: <20080627115349.743368154@saeurebad.de>
	<20080627120048.059732179@saeurebad.de>
	<20080628042240.GB25492@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:49016 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbYF1K0c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Jun 2008 06:26:32 -0400
In-Reply-To: <20080628042240.GB25492@linux-sh.org> (Paul Mundt's message of
	"Sat, 28 Jun 2008 13:22:40 +0900")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi,

Paul Mundt <lethal@linux-sh.org> writes:

> On Fri, Jun 27, 2008 at 01:53:51PM +0200, Johannes Weiner wrote:
>> This implements a platform-independent version of show_mem().
>> 
>> Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
>
> Looking at this again, does having this as a Kconfig option really make
> sense? We have no tristate in-tree users of this that I can see, wouldn't
> this be better off in lib/? It would be preferable not to let the
> HAVE_foo stuff get out of hand if we can avoid it.

I hate the current Kconfig usage, too.  But I figured, if I won't obey
on such decisions by people who maintain it, it won't have a chance to
get in.

So, what do you suggest?  Moving it to lib/ and have one simple #define
if the arch wants to use it or not?

	Hannes
