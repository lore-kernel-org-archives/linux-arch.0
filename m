Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:51786 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbYBAOtZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 Feb 2008 09:49:25 -0500
From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: Are Section mismatches out of control?
References: <20080201104718.GA11717@uranus.ravnborg.org>
	<20080201030329.9b760777.akpm@linux-foundation.org>
Date: Fri, 01 Feb 2008 15:48:43 +0100
In-Reply-To: <20080201030329.9b760777.akpm@linux-foundation.org> (Andrew
	Morton's message of "Fri, 1 Feb 2008 03:03:29 -0800")
Message-ID: <87y7a4wx4k.fsf@saeurebad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>

Hi,

Andrew Morton <akpm@linux-foundation.org> writes:

> Question is: why do people keep adding new ones when they are so easy to
> detect and fix?
>
> Asnwer: because neither they nor their patch integrators are doing adequate
> compilation testing.

How about adding an Untested-by tag for psychological reasons?

	Hannes
