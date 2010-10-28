Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55890 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758818Ab0J1ODx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Oct 2010 10:03:53 -0400
Subject: Re: [PATCH] parisc: fix compile failure with kmap_atomic changes
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <20101028051807.539484D30@hiauly1.hia.nrc.ca>
References: <20101028051807.539484D30@hiauly1.hia.nrc.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Oct 2010 09:03:49 -0500
Message-ID: <1288274629.3043.1.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John David Anglin <dave@hiauly1.hia.nrc.ca>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, peterz@infradead.org
Message-ID: <20101028140349.Hy77OslbJ-bZ1DtWQjfOPA91y_5KQvXKxl5M9bTNA7E@z>

On Thu, 2010-10-28 at 01:18 -0400, John David Anglin wrote:
> Signed-off-by: John David Anglin  <dave.anglin@nrc-cnrc.gc.ca>
> 
> Sent effectively the same change to parisc-linux list months ago...

You did?  Why didn't you send it to Peter?  When I grumbled at him on
IRC for breaking parisc (as well as quite a few other 64 bit
architectures in mainline) he had no idea there was a problem.

James


