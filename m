Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44108 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762845AbYBALE4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Feb 2008 06:04:56 -0500
Date: Fri, 1 Feb 2008 03:03:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Are Section mismatches out of control?
Message-Id: <20080201030329.9b760777.akpm@linux-foundation.org>
In-Reply-To: <20080201104718.GA11717@uranus.ravnborg.org>
References: <20080201104718.GA11717@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>

On Fri, 1 Feb 2008 11:47:18 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:

> James said in a related posting that the Section mismatch
> warnings were getting out of control.

eh.  They're easy - the build system tells you about them!

> The list is here:

Question is: why do people keep adding new ones when they are so easy to
detect and fix?

Asnwer: because neither they nor their patch integrators are doing adequate
compilation testing.

> I will look at drivers/isdn as next step.

Thanks.
