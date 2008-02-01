Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:56484 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757316AbYBAWK1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Feb 2008 17:10:27 -0500
Subject: Re: Are Section mismatches out of control?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <Pine.LNX.4.64.0802012245250.18790@fbirervta.pbzchgretzou.qr>
References: <20080201104718.GA11717@uranus.ravnborg.org>
	 <20080201030329.9b760777.akpm@linux-foundation.org>
	 <1201864894.23523.117.camel@brick>
	 <Pine.LNX.4.64.0802012245250.18790@fbirervta.pbzchgretzou.qr>
Content-Type: text/plain
Date: Fri, 01 Feb 2008 16:10:19 -0600
Message-Id: <1201903819.3134.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>


On Fri, 2008-02-01 at 22:47 +0100, Jan Engelhardt wrote:
> On Feb 1 2008 03:21, Harvey Harrison wrote:
> >> 
> >> Question is: why do people keep adding new ones when they are so easy to
> >> detect and fix?
> >> 
> >> Asnwer: because neither they nor their patch integrators are doing adequate
> >> compilation testing.
> >
> >[...]
> >Unless they break the build, or if there currently are 0 and they make
> >it non-zero, people seem not to care....sad.  Probably the same for
> >sparse/checkpatch, "there's plenty already, I can't be bothered to look"
> 
> checkpatch does not parse C, it uses heuristical regexes.
> 
> That makes it very different from sparse or the section mismatch
> finder which do not output false positives.

Even by the exalted standards of LKML which sometimes seems to make a
virtue of misinformation, four wrong statements in twenty seven words is
pretty impressive ... I salute you!

James


