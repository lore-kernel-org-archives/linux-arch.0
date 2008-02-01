Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.228]:19039 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbYBALWL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Feb 2008 06:22:11 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1042543hue.21
        for <linux-arch@vger.kernel.org>; Fri, 01 Feb 2008 03:22:10 -0800 (PST)
Subject: Re: Are Section mismatches out of control?
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <20080201030329.9b760777.akpm@linux-foundation.org>
References: <20080201104718.GA11717@uranus.ravnborg.org>
	 <20080201030329.9b760777.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 01 Feb 2008 03:21:34 -0800
Message-Id: <1201864894.23523.117.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>

On Fri, 2008-02-01 at 03:03 -0800, Andrew Morton wrote:
> On Fri, 1 Feb 2008 11:47:18 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > James said in a related posting that the Section mismatch
> > warnings were getting out of control.
> 
> eh.  They're easy - the build system tells you about them!
> 
> > The list is here:
> 
> Question is: why do people keep adding new ones when they are so easy to
> detect and fix?
> 
> Asnwer: because neither they nor their patch integrators are doing adequate
> compilation testing.

Because if there already exists more than a handful peoples' eyes glaze
over and ignore "just one more warning"

Unless they break the build, or if there currently are 0 and they make
it non-zero, people seem not to care....sad.  Probably the same for
sparse/checkpatch, "there's plenty already, I can't be bothered to look"

Subject to someone _making_ it an issue, can't see it changing.

Harvey

