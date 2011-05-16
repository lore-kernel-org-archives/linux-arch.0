From: Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [patch 3/4] ia64 mcount offset calculation
Date: Mon, 16 May 2011 16:41:06 -0400
Message-ID: <1305578466.5456.27.camel@gandalf.stny.rr.com>
References: <20110510081039.241831019@de.ibm.com>
	 <20110510081103.902546467@de.ibm.com>
	 <1305572301.5456.24.camel@gandalf.stny.rr.com>
	 <987664A83D2D224EAE907B061CE93D5301CD197F7B@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:53838 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab1EPUlJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 May 2011 16:41:09 -0400
In-Reply-To: <987664A83D2D224EAE907B061CE93D5301CD197F7B@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Mon, 2011-05-16 at 12:17 -0700, Luck, Tony wrote:
> I'm not sure how to test it - but it looks somewhat suspect.

You could apply the first patch and this patch and see if ftrace still
works :)

> 
> The difficulty is in the way that ia64 tools report program addresses within bundles.
> 
> ia64 crams 3 41-bit instructions (and a 5-bit template) into a 16-byte "bundle".
> 
> Some tools report consecutive addresses like this:
> 
> 0x000
> 0x001
> 0x002
> 0x010
> 0x011
> 0x012
> 
> where the low nibble is the instruction number within the bundle.  Others go
> for:
> 
> 0x000
> 0x006
> 0x00c
> 0x010
> 0x016
> 0x01c
> 
> with the illusion that instructions take 6-byte, 6bytes, 4-bytes.

And I'm amazed that this wonderful architecture didn't become the
defacto for all users!


> 
> This patch does some fast and loose translation from hex (0x12) in the kernel
> to decimal (18) in the user tools ... which doesn't look like it fits with
> either of these conventions.

Could be broken. I'll leave it out of my next push.

Thanks,

-- Steve
