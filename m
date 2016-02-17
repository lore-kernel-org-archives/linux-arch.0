Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:58007 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756766AbcBQIWR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2016 03:22:17 -0500
Received: from localhost
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Wed, 17 Feb 2016 08:22:16 -0000
Date: Wed, 17 Feb 2016 09:22:10 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
Message-ID: <20160217082210.GA4175@osiris>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
 <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
 <20160128121618.GB5418@osiris>
 <20160128163109.GA8529@yury-N73SV>
 <20160201114251.GB973@yury-N73SV>
 <20160202073913.GB3990@osiris>
 <20160202154331.GA3003@yury-N73SV>
 <20160202160826.GF3990@osiris>
 <20160202195434.GA3397@osiris>
 <20160202204156.GA27290@yury-N73SV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160202204156.GA27290@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, catalin.marinas@arm.com, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
Message-ID: <20160217082210.PsFqgIoU7GtA530ZAzUe8OGkyiU_Mjm0OyTbtLl1oR4@z>

On Tue, Feb 02, 2016 at 11:41:56PM +0300, Yury Norov wrote:
> > However I'll try to write an addon patch to your patch series. Maybe we can
> > still get rid of compat_wrapper.c in a way which makes both of us happy.
> > Also.. the idea with the alias names for compat wrappers does seem to have
> > the disadvantage that it will pollute /proc/kallsyms for example.
> > 
> > Anyway, I'm not sure if I will be able to come up with something this week
> > though.
> 
> Great, I'm looking forward...

Hi Yuri,

after playing around with this a bit I couldn't come up with a solution
that I'm happy with, unfortunately.

So in order to make some progress here I'd vote that we simply move the
existing compat_wrapper.c from arch/s390 to common code like you did in
your first approach and leave the existing SYSCALL macros alone.

That will have hardly any effect to anybody else and your problem is
solved while s390 still works.

Does that make sense?

