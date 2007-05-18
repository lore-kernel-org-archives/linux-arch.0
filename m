Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49577 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291AbXERJEF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2007 05:04:05 -0400
From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 06/14] kbuild: introduce __init_refok/__initdata_refok to supress section mismatch warnings
References: <20070518064126.GA12193@uranus.ravnborg.org>
	<20070518065352.GF12284@uranus.ravnborg.org>
Date: Fri, 18 May 2007 11:03:57 +0200
In-Reply-To: <20070518065352.GF12284@uranus.ravnborg.org> (Sam Ravnborg's
	message of "Fri\, 18 May 2007 08\:53\:52 +0200")
Message-ID: <jefy5uec5e.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

Sam Ravnborg <sam@ravnborg.org> writes:

> + * The follwoing markers are used for the cases where the reference to

s/follwoing/following/

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
